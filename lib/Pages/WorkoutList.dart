import 'dart:math';

import 'package:bmi_app/Services/CheckInternetConnectionService.dart';
import 'package:bmi_app/Services/FetchExerciseDataService.dart';
import 'package:bmi_app/Services/FetchHealthDataService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constraints/ListVariables.dart';
import 'DisplayExerciseData.dart';
import '../Providers/ExercisesDataProvider.dart';

class WorkoutList extends StatefulWidget{
  int muscleMapIndex;

  WorkoutList({required this.muscleMapIndex});

  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  Random rd=Random();
  static bool isConnected=false;
  static bool error=false;
  void initState(){
    checkIfConnected();
  }
  FetchExerciseDataService exe=FetchExerciseDataService();
  ListVariables variable=ListVariables();
  CheckInternetConnection con=CheckInternetConnection();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor:Colors.transparent,),
      body:Column(
        children: [
             Expanded(
              child: SingleChildScrollView(
                child: ChangeNotifierProvider<ExercisesDataProvider>(
                    create:(context)=> ExercisesDataProvider(),
                    child:Consumer<ExercisesDataProvider>(
                      builder: (context,provider,child){
                        return isConnected==true?FutureBuilder<List>(
                          future: provider.getExercisesLists(widget.muscleMapIndex),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(snapshot.hasData){
                              return Center(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (BuildContext context,int i){
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Card(
                                              color: Color.fromRGBO(37, 32, 36, 1),
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  foregroundImage:NetworkImage(
                                                      variable.exeImages[rd.nextInt(variable.exeImages.length)]
                                                  ),
                                                ),
                                                title: Text(snapshot.data[i],style: TextStyle(fontWeight: FontWeight.normal,color: Colors.white),),
                                                trailing: IconButton(icon:Icon(CupertinoIcons.right_chevron,color: Colors.white), onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayExerciseData(workoutName: snapshot.data[i])));
                                                },),
                                              ),
                                            ),
                                          );
                                        }
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return FetchExerciseDataService.error!=true?Column(
                                children: [
                                  SizedBox(height: 200,),
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              ):Column(
                                children: [
                                  SizedBox(
                                    height:100,
                                  ),
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image:DecorationImage(image: AssetImage('assets/images/network_error.gif'))
                                    ),
                                  ),
                                  Text('Some Error Occured',style: TextStyle(color: Colors.white,fontSize: 23),),
                                ],
                              );
                            }

                          },
                        ):Column(
                          children: [
                            SizedBox(
                              height:100,
                            ),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  image:DecorationImage(image: AssetImage('assets/images/network_error.gif'))
                              ),
                            ),
                            Text('Please Check your Internet',style: TextStyle(color: Colors.white,fontSize: 23),),
                          ],
                        );
                      },)
                ),
              ),
            ),
          ]

      ),
    );
  }

  void checkIfConnected() async{
    bool status =await con.checkInternetConnection();
    setState((){
      isConnected=status;
      error=FetchExerciseDataService.error;
    });
  }
}
import 'dart:math';
import 'package:bmi_app/Pages/DayWiseExercises.dart';
import 'package:bmi_app/Providers/ExercisesDataProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Constraints/ListVariables.dart';

class ThirtyDaysWorkout extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
     return _ThirtyDaysWorkoutState();
  }

}

class _ThirtyDaysWorkoutState extends State<ThirtyDaysWorkout>{

  ExercisesDataProvider? provider=null;
  ListVariables variable=ListVariables();
  List duration=[30,45];
  bool isCompleted=false;
  var sh;
  int j=0;
  Random rd=Random();
  DayWiseExercises d=DayWiseExercises(i:0,);
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text("30 Days Workout"),
        backgroundColor: Color.fromRGBO(37, 32, 36, 0),),
      body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ThirtyDaysWorkout()));},
                  child: Container(
                      child: Row(
                        children: [
                          Container(
                            height:0.20*MediaQuery.of(context).size.height,
                            width: 0.30*MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/workout_image2.jpg'),
                                    fit:BoxFit.fill )
                            ),
                          ),
                          Text("You are doing great"
                              " \n Keep Exercising",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      height:0.25*MediaQuery.of(context).size.height ,
                      decoration:BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0),topRight: Radius.circular(20.0),bottomLeft: Radius.circular(20.0))
                      )
                  ),
                ),
              ),
              Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  for(int i=1;i<=30;i++)...{
                    createExeCards(i)
                   }
                  ],
                 ),
                )
              )
            ],
         ),
      );
   }

  createExeCards(int i) {

    int day = i;
    late int k;
    late String difficulty;
    if (i % 2 == 0) {
      k = (i ~/ 2);
      difficulty = "Intermediate-Expert";
    } else {
      k = ((i + 1) ~/ 2);
      difficulty = "Beginner-Intermediate";
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => DayWiseExercises(i: day)));
        },
        child: Material(
          color: Colors.black,
          elevation: 5.0,
          child: Container(
            height: 100,
            child: Card(
              color: Color.fromRGBO(37, 32, 36, 1),
              elevation: 5,
              child: ListTile(
                  title: Text("Day $i", style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Target Muscle:-${variable.Muscles['Day$k']}",
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      Text("Difficulty Level:-$difficulty",
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      Row(
                        children: [
                          Text("300cal", style: TextStyle(fontSize: 15,
                              color: Colors.white),),
                          Icon(CupertinoIcons.flame, color: Colors.white,),
                          SizedBox(
                            width: 20,
                          ),
                          Text("${duration[rd.nextInt(duration.length)]}mins",
                            style: TextStyle(fontSize: 15,
                                color: Colors.white),),
                          Icon(CupertinoIcons.clock, color: Colors.white,),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(CupertinoIcons.right_chevron,color: Colors.white,)

              ),
            ),
          ),
        ),
      ),
    );
  }


  }

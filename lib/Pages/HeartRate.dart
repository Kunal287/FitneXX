import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'HealthTracker.dart';
import '../Providers/HealthDataProvider.dart';
class HeartRate extends StatefulWidget{
  @override
  State<HeartRate> createState() => _HeartRateState();
}

class _HeartRateState extends State<HeartRate> {
  String dropdownValue = "beginner";
  var items = [
    'beginner',
    'intermediate',
    'advanced',
  ];
  static String _item='beginner';


  @override
  Widget build(BuildContext context) {
    TextEditingController age=TextEditingController();
    TextEditingController fitness_level=TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ChangeNotifierProvider<HealthDataProvider>(
                  create:(context)=> HealthDataProvider(),
                  child:Consumer<HealthDataProvider>(
                      builder: (context,provider,child){
                        return Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Understanding Target heart rate can help people figure out how effectively they are exercising. "
                                  ,style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(decoration: InputDecoration(fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.white),
                                  labelText: 'Age',
                                  //suffixText: "CM",suffixStyle: TextStyle(color: Colors.white,fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                        width: 3, color: Color.alphaBlend(Colors.white, Colors.black)), //<-- SEE HERE
                                  )),style: TextStyle(color: Colors.white),controller: age,keyboardType: TextInputType.number,),
                            ),

// Step 2.
                            DropdownButton<String>(
                                dropdownColor: Colors.black,
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                style: const TextStyle(color: Colors.white),
                                underline: Container(
                                  height:1,
                                  color: Colors.black,
                                ),
                                onChanged:(String? newValue){
                                  setState(() {
                                    dropdownValue=newValue!;
                                  });
                                },
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'beginner',
                                      child: Text('beginner',style: TextStyle(color: Colors.white)),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'intermediate',
                                    child: Text('intermediate',style: TextStyle(color: Colors.white),),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'advanced',
                                    child: Text('advanced',style: TextStyle(color: Colors.white)),
                                  ),
                                ]
                            ),
                            Align(
                              alignment:Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment : MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(onPressed: (){

                                    age.text!=""?
                                    Provider.of<HealthDataProvider>(context,listen: false).getHeartRateData(age.text,dropdownValue):
                                    Fluttertoast.showToast(
                                      msg: "Please Enter your age",
                                    );

                                  }, child:Text("Calculate THR")),
                                  IconButton(onPressed: (){
                                    age.text="";
                                    fitness_level.text="";
                                    provider.clearAll();
                                  }, icon: Icon(Icons.delete,color: Colors.white,))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            provider.THRData.length!=0?
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(width: 5, color: Colors.red),
                                    borderRadius: BorderRadius.all(Radius.circular(16.0))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Min Target Heart Rate :- ${provider.THRData[0]}",style: TextStyle(color: Colors.white,fontSize: 20),),
                                      Text("Max Target Heart Rate :- ${provider.THRData[1]}",style: TextStyle(color: Colors.white,fontSize: 20),),

                                    ],
                                  ),
                                ),
                              ),
                            ):Center(
                              child: Container(
                                height:200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/heartbeat.gif")
                                  )
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                  )
              ),
            ),
          ),
        ],
      ) ,
    );
  }
}
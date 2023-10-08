import 'package:bmi_app/Pages/BMI.dart';
import 'package:bmi_app/Pages/HeartRate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Dashboard.dart';
class HealthTracker extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return HealthTrackerState();
  }

}

class HealthTrackerState extends State<HealthTracker>{
  List calculationsType=["BMI","Heart Rate","Ideal Weight","BMR"];
  List Images=["BMI.jpg","HeartRate.jpg","IdealWeight.jpg","BMR.jpg"];
  List Pages=[BMI(),HeartRate(),BMI(),BMI()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromRGBO(37, 32, 36, 1),
      body:Column(
        mainAxisAlignment:MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: IconButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
            }, icon: Icon(CupertinoIcons.arrow_left,color: Colors.white,size: 25,)),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Get to know all about your Important health updates here",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.builder(
              physics: ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 4/4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              shrinkWrap: true,
              itemCount: Images.length,
              itemBuilder: (BuildContext context, i) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                              height:MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Pages[i]));
                                    },
                                    child: Container(
                                      height: 110,
                                      width: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage("assets/images/${Images[i]}"),fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(15),
                                      ),

                                    ),
                                  ),
                                   SizedBox(
                                     height:10
                                   ),
                                   Text(calculationsType[i],style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),

                );
              }),

        ],
      )
    );
  }
}
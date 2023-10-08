import 'package:bmi_app/Pages/HealthTracker.dart';
import 'package:bmi_app/Services/FetchExerciseDataService.dart';
import 'package:bmi_app/Services/FetchHealthDataService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Providers/HealthDataProvider.dart';
class BMI extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _BMIState();
  }

}

class _BMIState extends State<BMI>{
  TextEditingController weight=TextEditingController();
  TextEditingController height=TextEditingController();
  void initState(){
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,),
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
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [

                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text("BMI is a measurement that is a ratio of your weight and height. ",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: TextField(decoration: InputDecoration(fillColor: Colors.white,
                                   labelStyle: TextStyle(color: Colors.white),
                                   labelText: 'Height in Centimeters',
                                   suffixText: "CM",suffixStyle: TextStyle(color: Colors.white,fontSize: 15),
                                   enabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                     borderSide: BorderSide(
                                         width: 3, color: Color.alphaBlend(Colors.white, Colors.black)), //<-- SEE HERE
                                   )),style: TextStyle(color: Colors.white),controller: height,),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: TextField(decoration: InputDecoration(fillColor: Colors.white,
                                   labelStyle: TextStyle(color: Colors.white),
                                   labelText: 'Weight in Kilograms',
                                   suffixText: "Kg",suffixStyle: TextStyle(color: Colors.white,fontSize: 15),
                                   enabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                     borderSide: BorderSide(
                                         width: 3, color: Color.alphaBlend(Colors.white, Colors.black)), //<-- SEE HERE
                                   )),style: TextStyle(color: Colors.white),controller: weight,),
                             ),
                             Align(
                               alignment:Alignment.center,
                               child: Row(
                                 mainAxisAlignment:MainAxisAlignment.center,
                                   children: [
                                     ElevatedButton(onPressed: (){
                                       height.text!="" && weight.text !=""?Provider.of<HealthDataProvider>(context,listen: false).getbmiData(height.text,weight.text):
                                       Fluttertoast.showToast(
                                         msg: "Please Enter all fields",
                                       );
                                     }, child:Text("Calculate BMI")),
                                     IconButton(onPressed: (){
                                       height.text="";
                                       weight.text="";
                                       provider.clearAll();
                                     }, icon: Icon(Icons.delete,color: Colors.white,))
                                   ],
                                 ),
                             ),
                             SizedBox(
                               height: 50,
                             ),
                             if(provider.bmiData.length!=0)...{
                               Container(
                               height: 200,
                               decoration: BoxDecoration(
                               color:  Color.fromRGBO(37, 32, 36, 1),
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
                               SizedBox(
                               height: 20,
                            ),
                              Text("BMI :- ${provider.bmiData[0]}",style: TextStyle(color: Colors.white,fontSize: 20),),
                              Text("Height :- ${provider.bmiData[1]}",style: TextStyle(color: Colors.white,fontSize: 20),),
                              Text("Weight :- ${provider.bmiData[2]}",style: TextStyle(color: Colors.white,fontSize: 20),),
                              Text("Weight Status :- ${provider.bmiData[3]}",style: TextStyle(color:provider.bmiData[3]=="Healthy weight"?Colors.green:
                              provider.bmiData[3]=="Overweight"?Colors.orange:provider.bmiData[3]=="Obese"?Colors.red:Colors.red,fontSize: 20),),

                              ],
                            ),
                          ),
                        )
                       }

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

import 'package:bmi_app/Providers/FoodDataProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodNutritionPage extends StatelessWidget{
  TextEditingController query=TextEditingController();
  @override
  Widget build(BuildContext context) {

    double deviceheight=MediaQuery.of(context).size.height;
    double devicewidth=MediaQuery.of(context).size.width;
  return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(backgroundColor: Colors.black),
    body: Column(
        mainAxisAlignment:MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: ChangeNotifierProvider<FoodDataProvider>(
                create:(context)=> FoodDataProvider(),
                    child:Consumer<FoodDataProvider>(
                        builder: (context,provider,child){
                            return Center(
                                child: Column(
                                  children: [
                                      SizedBox(
                                      height: 20,
                                      ),
                                      CircleAvatar(
                                        radius: 80,
                                        backgroundImage: AssetImage('assets/images/Macronutrients.jpg'),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Nutrition is a critical part of health and development.",style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: TextField(decoration: InputDecoration(fillColor: Colors.red,
                                        labelStyle: TextStyle(color: Colors.white),
                                        labelText: 'Search to know Nutritonal values',
                                        suffixIcon: IconButton(onPressed: (){
                                         provider.fetchFoodNutritonData(query.text);

                                        },
                                        icon: Icon(Icons.search,color: Colors.white,),),
                                        enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                    borderSide: BorderSide(
                                                        width: 3, color: Color.alphaBlend(Colors.white, Colors.black)), //<-- SEE HERE
                                                  )),style: TextStyle(color: Colors.white),controller:query ,),
                                        ),
                                    ElevatedButton(onPressed: (){
                                      provider.nutritionData.clear();

                                      query.text="";
                                      provider.clearAll();
                                    },
                                        child: Text("clear")),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics: ClampingScrollPhysics(),
                                              itemCount: provider.nutritionData.length,
                                              itemBuilder: (BuildContext context,int i){
                                                return Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Card(
                                                    color: Color.fromRGBO(37, 32, 36, 1),
                                                    child: ListTile(
                                                      title: Text("Food :- ${provider.nutritionData[i]["name"]}",style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                                                      subtitle: Column(
                                                        children: [
                                                          Align(alignment:Alignment.topLeft,child: Text("Calories:- ${provider.nutritionData[i]["calories"]}",style: TextStyle(color: Colors.white,fontSize: 20),)),
                                                          Align(alignment:Alignment.topLeft,child: Text("Protein:- ${provider.nutritionData[i]["protein_g"]}g",style: TextStyle(color: Colors.white,fontSize: 20))),
                                                          Align(alignment:Alignment.topLeft,child: Text("Fats:- ${provider.nutritionData[i]["fat_total_g"]}g",style: TextStyle(color: Colors.white,fontSize: 20),)),
                                                          Align(alignment:Alignment.topLeft,child: Text("Sodium:- ${provider.nutritionData[i]["sodium_mg"]}mg",style: TextStyle(color: Colors.white,fontSize: 20))),
                                                          Align(alignment:Alignment.topLeft,child: Text("Carbohydrates:- ${provider.nutritionData[i]["carbohydrates_total_g"]}g",style: TextStyle(color: Colors.white,fontSize: 20),)),
                                                          Align(alignment:Alignment.topLeft,child: Text("Fibers:- ${provider.nutritionData[i]["fiber_g"]}g",style: TextStyle(color: Colors.white,fontSize: 20))),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                           ),
                                        ],
                                      ),
                                    );
                                  }
                                )
                             ),
                            ),
                          ),
                        ],
                      )
                  );
              }
          }
import 'package:bmi_app/Pages/FoodNutritionPage.dart';
import 'package:bmi_app/Pages/HealthTracker.dart';
import 'package:bmi_app/Pages/YogaDataProvider.dart';
import 'package:bmi_app/Pages/YogaCategories.dart';
import 'package:flutter/material.dart';
import '30DaysWorkoutList.dart';
import 'Exercises.dart';
class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return HomePageState();
  }
}
class HomePageState extends State<HomePage> {
  List Images=["Plank.jpg","yoga-asanas.jpg","TRX.jpg","Food.jpg"];
  List Titles=["Workouts","Yoga","Health Tracker","Food & Nutrition"];
  List Screens=[Exercises(),YogaCategories(),HealthTracker(),FoodNutritionPage()];
  @override
  Widget build(BuildContext context) {
    double deviceheight=MediaQuery.of(context).size.height;
    double devicewidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Colors.black,
      body: Column(
          mainAxisAlignment :MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ThirtyDaysWorkout()));},
            child: Container(
            child: Row(
            children: [
              Container(
              height: 0.18*deviceheight,
              width: 0.30*devicewidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/workout_image1.gif'),
                      fit:BoxFit.fill )
              ),
            ),
            Text("Start Your 30days \nWorkout Challenge",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
            Padding(padding:EdgeInsets.only(right:10),child: IconButton(onPressed: (){}, icon: Icon(Icons.play_circle,size: 40,)))
               ],
            ),
            height:0.25*deviceheight ,
            decoration:BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0),topRight: Radius.circular(20.0),bottomLeft: Radius.circular(20.0))
              )
           ),
          ),
        ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Essentials",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            ),
            Expanded(
                child: GridView.builder(
                    physics: ClampingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 4/4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5),
                    shrinkWrap: true,
                    itemCount: Images.length,
                    itemBuilder: (BuildContext context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Screens[i]));},
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/${Images[i]}"),fit: BoxFit.cover,colorFilter:
                               ColorFilter.mode(Colors.black.withOpacity(0.7),BlendMode.dstATop),),
                                borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(Titles[i],style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      );
                    }),
               ),

          ],
        ),

      );
   }
}
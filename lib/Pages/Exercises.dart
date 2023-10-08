
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Constraints/ListVariables.dart';
import '../Providers/ExercisesDataProvider.dart';
import 'WorkoutList.dart';
import 'package:provider/provider.dart';
class Exercises extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ExercisesState();
  }

}

class _ExercisesState extends State<Exercises>{
  void initState(){
    super.initState();
  }
  List<String> sliderImgs=["Plank.jpg","legs_workout.jpg","yoga-asanas.jpg"];
  List exeFacts=["Boosts self-confidence","Running burns calories!","Increases productivity"];
  int j=0;
  ListVariables variable=ListVariables();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    String val="";

    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        title: Text("Workout Categories"),
         backgroundColor:Colors.black,),
      body:Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(
                height: 10,
              ),
              CarouselSlider(
                disableGesture: false,
                  items: [
                    for(int i=0;i<sliderImgs.length;i++)...[
                      createImagesSlider(sliderImgs[i],exeFacts[i])
                  ]

                  ], options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                          pageSnapping: true

                        ),

              ),
              Align(alignment:Alignment.topLeft,child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
              )),
              
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                         SingleChildScrollView(
                          child:ChangeNotifierProvider<ExercisesDataProvider>(
                              create:(context)=> ExercisesDataProvider(),
                              child:Consumer<ExercisesDataProvider>(
                                builder: (context,provider,child){
                                  return GridView.builder(
                                          physics: ClampingScrollPhysics(),
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 300,
                                              childAspectRatio: 4/4,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 5),
                                          shrinkWrap: true,

                                          itemCount: variable.exeImages.length,
                                          itemBuilder: (BuildContext context,j) {
                                            return Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkoutList(muscleMapIndex: j+1,)));
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(image: NetworkImage("${variable.exeImages[j]}"),fit: BoxFit.cover,colorFilter:
                                                    ColorFilter.mode(Colors.black.withOpacity(0.5),
                                                        BlendMode.dstATop),),
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  child: Text(variable.Muscles['Day${j+1}'],style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                                ),
                                              ),
                                            );
                                          });

                                },)
                          ),
                        ),

                      ]
                  ),
                )
                  ),
            ],
      ) ,
    );

  }

  Widget createImagesSlider(String myImag, exeFact) {
    return
      Container(
          height: 220,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            image:DecorationImage(
            image:AssetImage('assets/images/$myImag',),fit: BoxFit.cover,colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.8),
                BlendMode.dstATop),
          ),
          ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16,left: 8),
          child: Align(alignment:Alignment.center,child: Text(exeFact,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
        ),
        );

  }

}

import 'package:bmi_app/Constraints/ListVariables.dart';
import 'package:bmi_app/Pages/YogaPosesList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'YogaDataProvider.dart';

class YogaCategories extends StatefulWidget{
  @override
  State<YogaCategories> createState() => _YogaCategoriesState();
}

class _YogaCategoriesState extends State<YogaCategories> {
  ListVariables variables=ListVariables();
  @override
  Widget build(BuildContext context) {
    List poses=[];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Yoga Categories",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ChangeNotifierProvider<YogaDataProvider>(
                create:(context)=> YogaDataProvider(),
                child:Consumer<YogaDataProvider>(
                  builder: (context,provider,child){
                    return FutureBuilder<List<dynamic>>(
                      future: provider.getYogaData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        if(snapshot.hasData && variables.YogaImages.length!=0){
                          //print("snapshot is ${snapshot.data}");
                          return Center(
                            child: Column(
                              children: [
                                GridView.builder(
                                    physics: ClampingScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 300,
                                        childAspectRatio: 4/4,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 5),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (BuildContext context,int i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          onTap: (){
                                            provider.clearYogaPoses();
                                            poses=provider.getYogaPoses(i);
                                            print("Poses ${poses}");
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>YogaPosesList(poses: poses, posesImages:variables.YogaImages,i: i)));
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(image: NetworkImage("${variables.YogaImages[i]}"),fit: BoxFit.cover,opacity: 100),
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child: Text(snapshot.data[i]['category_name'],style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 200),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    );
                  },)
            ),
          ],
        ),
      ),
    );
  }
}



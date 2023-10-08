import 'package:bmi_app/Pages/YogaDataProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constraints/ListVariables.dart';

class YogaPoseDetailPage extends StatefulWidget{
  late String poseName;
  late int categoryId;

   YogaPoseDetailPage({required this.poseName,required this.categoryId});

  @override
  State<YogaPoseDetailPage> createState() => _YogaPoseDetailPageState();
}

class _YogaPoseDetailPageState extends State<YogaPoseDetailPage> {
  Map poseData={};
  List Images=[];
  bool isFavourite=false;
  ListVariables variables=ListVariables();
  @override
  Widget build(BuildContext context) {
    double deviceheight=MediaQuery.of(context).size.height;
    double devicewidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body: Column(
         children: [
       Padding(
         padding: const EdgeInsets.all(16.0),
         child: Container(
           child: Align(
             alignment: Alignment.bottomLeft,
             child: Row(
               mainAxisAlignment : MainAxisAlignment.end,
               children: [
                 IconButton(icon: Icon(CupertinoIcons.play,), onPressed: () {

                 },color: Colors.white,),
                 IconButton(icon: isFavourite==false?Icon(CupertinoIcons.heart,color: Colors.white,):Icon(CupertinoIcons.heart_fill,color: Colors.white,) , onPressed: () {
                     if(isFavourite){
                       setState(() {
                         isFavourite=false;
                       });

                     }else{
                       setState(() {
                         isFavourite=true;
                       });

                     }
                 }),
               ],
             ),
           ),
           height: 0.28*deviceheight,
           decoration: BoxDecoration(
             image: DecorationImage(image: NetworkImage("${variables.YogaImages[widget.categoryId]}"),fit: BoxFit.cover,opacity: 100),
             borderRadius: BorderRadius.all(Radius.circular(16.0)),
           ),
         ),
       ),
       Expanded(
        child: SingleChildScrollView(
        child: ChangeNotifierProvider<YogaDataProvider>(
        create:(context)=> YogaDataProvider(),
        child:Consumer<YogaDataProvider>(
         builder: (context,provider,child){
                 return  FutureBuilder<Map>(
                 future: provider.getYogaPoseData(widget.poseName),
                 builder: (BuildContext context, AsyncSnapshot snapshot){
                   return Padding(
                     padding: const EdgeInsets.only(left: 16.0,top: 16.0,right:8.0),
                     child: Column(
                       mainAxisAlignment : MainAxisAlignment.start,
                       crossAxisAlignment : CrossAxisAlignment.start,
                       children: [
                         if(snapshot.hasData)...[

                             Text("English Name:- ${snapshot.data['english_name']}",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:'OpenSans'),),
                           SizedBox(
                             height: 20,
                           ),
                           Text("Sanskrit Name:- ${snapshot.data['sanskrit_name_adapted']}",style: TextStyle(color: Colors.white,fontSize: 20)),
                           SizedBox(
                             height: 20,
                           ),
                             Text("Translation:-  ${snapshot.data['translation_name']}",style: TextStyle(color: Colors.white,fontSize: 20)),
                           SizedBox(
                             height: 20,
                           ),
                           Text("Pose Description :-  ${snapshot.data['pose_description']}",style: TextStyle(color: Colors.white,fontSize: 20)),
                           SizedBox(
                             height: 20,
                           ),
                           Text("Pose Benefits :-  ${snapshot.data['pose_benefits']}",style: TextStyle(color: Colors.white,fontSize: 20)),
                         ]else...[
                           SizedBox(height: 100,),
                           CircularProgressIndicator(),
                         ],
                       ],
                     ),
                   );
                  }
                  );
                }
                )
               )
             ),
            )
         ],
       ),
     );
   }

}
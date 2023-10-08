import 'dart:math';

import 'package:bmi_app/Pages/YogaDataProvider.dart';
import 'package:bmi_app/Pages/YogaPoseDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class YogaPosesList extends StatelessWidget{
  List poses;
  late List posesImages;
  late int i;
  Random rd=Random();
  YogaPosesList({required this.poses,required this.posesImages,required this.i});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Column(
        children: [
          Expanded(child:SingleChildScrollView(
              child: Column(
                children: [
                    Center(
                    child: Column(
                    children: [
                        ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: poses.length,
                        itemBuilder: (BuildContext context,int j){
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              color: Color.fromRGBO(37, 32, 36, 1),
                              child: ListTile(
                                leading: CircleAvatar(
                                  foregroundImage: NetworkImage(
                                   posesImages[rd.nextInt(posesImages.length)]
                                  ),
                                ),
                                title: Text(poses[j],style: TextStyle(fontWeight: FontWeight.normal,color: Colors.white),),
                                trailing: IconButton(icon:Icon(CupertinoIcons.right_chevron,color: Colors.white), onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>YogaPoseDetailPage(poseName:poses[j], categoryId: i)));
                                },),
                              ),
                            ),
                          );
                        }
                       )
                      ],
                     ),
                    )
                ],
              )
            )
          )
        ],
      ),
    );
  }

}
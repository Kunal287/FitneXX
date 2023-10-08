import 'dart:io';

import 'package:bmi_app/Pages/Exercises.dart';
import 'package:bmi_app/Providers/FavouritesProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Services/DatabaseService.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Providers/ExercisesDataProvider.dart';

class DisplayExerciseData extends StatefulWidget {
  String workoutName="";
  String videoId="FMjFTlzD0RE";
  List favourites=[];
  DisplayExerciseData({required this.workoutName});

  @override
  _DisplayExerciseDataState createState() => _DisplayExerciseDataState();
}

class _DisplayExerciseDataState extends State<DisplayExerciseData> {
  YoutubePlayerController? _controller;
  bool isConnected=false;
  bool isFavourite=false;
  DatabaseService service=DatabaseService();
  @override
  void initState() {
    checkInternetConnection();
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:widget.videoId ??"",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )
      ..addListener(listener);
  }

  void listener() {
    if (_controller?.value.errorCode != null) {
      print(_controller?.value.errorCode);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Workout Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            isConnected==true?Expanded(
              child: SingleChildScrollView(
                  child:  Column(
                              children: [
                                  Container(
                                    decoration: BoxDecoration(

                                    ),
                                    child: YoutubePlayer(
                                      controller: _controller!,
                                      showVideoProgressIndicator: true,
                                      onReady: () {
                                        print('Player is ready.');
                                      },
                                      onEnded: (data) {
                                        _controller!
                                          ..load(widget.videoId ?? "")
                                          ..play();
                                      },
                                    ),
                                  ),
                                ChangeNotifierProvider<ExercisesDataProvider>(
                                    create:(context)=> ExercisesDataProvider(),
                                    child:Consumer<ExercisesDataProvider>(
                                      builder: (context,provider,child){
                                      return FutureBuilder<List>(
                                      future: provider.getExercisesData(widget.workoutName),
                                      builder: (BuildContext context, AsyncSnapshot snapshot){
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 16.0,top: 16.0,right:8.0),
                                          child: Column(
                                            mainAxisAlignment : MainAxisAlignment.start,
                                            crossAxisAlignment : CrossAxisAlignment.start,
                                            children: [
                                              if(snapshot.hasData && isConnected==true)...[
                                                Row(
                                                  children:[
                                                    Text("Add to Favourites",style: TextStyle(color: Colors.white,fontSize: 20),),
                                                    IconButton(icon: isFavourite==false?Icon(CupertinoIcons.heart,color: Colors.white,):Icon(CupertinoIcons.heart_fill,color: Colors.white,) ,
                                                        onPressed: () async{
                                                          if(DatabaseService.checkIfExistInFavourites(widget.workoutName)==true){
                                                            DatabaseService.removeFromFavourite(widget.workoutName);
                                                            Fluttertoast.showToast(
                                                              msg: "Removed from favourites",
                                                            );
                                                            setState(() {
                                                              isFavourite=false;
                                                            });

                                                          }else{
                                                            DatabaseService.addToFavourites(widget.workoutName);
                                                            Fluttertoast.showToast(
                                                              msg: "Added to favourites",
                                                            );

                                                            setState(() {
                                                              isFavourite=true;
                                                            });
                                                          }
                                                        }),
                                                  ],
                                                ),
                                                Text("Workout Name:- ${snapshot.data[0]['name']}",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:'OpenSans'),),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Workout Type:- ${snapshot.data[0]['type']}",style: TextStyle(color: Colors.white,fontSize: 20)),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Target Muscle:-  ${snapshot.data[0]['muscle']}",style: TextStyle(color: Colors.white,fontSize: 20)),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Equipment :-  ${snapshot.data[0]['equipment']}",style: TextStyle(color: Colors.white,fontSize: 20)),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Difficulty :-  ${snapshot.data[0]['difficulty']}",style: TextStyle(color: Colors.white,fontSize: 20)),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Instructions :-  ${snapshot.data[0]['instructions']}",style: TextStyle(color: Colors.white,fontSize: 20)),
                                              ]else if(snapshot.data==null && provider.isLoading==false)...[
                                                Center(
                                                  child: Text('Some Error Occured',style: TextStyle(color: Colors.white,fontSize: 20),),
                                                )
                                              ]else...[
                                                Center(
                                                    child: CircularProgressIndicator()
                                                )


                                              ]
                                            ],
                                          ),
                                        );
                                      }
                                    );
                                }
                            )
                         )
                     ],
                  )

              ),
            ):Column(
               children: [
                   SizedBox(
                  height:100,
                  ),
                   Container(
                  height: 100,
                  decoration: BoxDecoration(
                  image:DecorationImage(image: AssetImage('assets/images/network_error.gif'))
                  ),
                  ),
                   Text('Some Error Occured',style: TextStyle(color: Colors.white,fontSize: 23),),
                ],
            )

          ]
        ),
      ),
    );
  }
 checkInternetConnection() async{
  try {
  final result = await InternetAddress.lookup('example.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
     setState(() {
       isConnected=true;
     });
  }
  } on SocketException catch (_) {
     setState(() {
       isConnected=false;
     });
  }

    }
}
import 'dart:convert';
import 'dart:math';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constraints/ListVariables.dart';
import 'package:bmi_app/Services/CheckInternetConnectionService.dart';
import 'package:bmi_app/Services/FetchExerciseDataService.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class ExercisesDataProvider with ChangeNotifier{
  List exeData=[];
  List exeList=[];
  List favourites=[];
  bool isLoading=true;
  Random rd=Random();
  bool isCompleted=false;
  FetchExerciseDataService fetchExerciseDataService=FetchExerciseDataService();
  ListVariables variable=ListVariables();
  int time=0;
  CheckInternetConnection conn=CheckInternetConnection();
  Future<List<dynamic>> fetchExerciseDataByDays(int i) async{
    if (i % 2 == 0) {
     int k = i~/2;
      print("k1 is $k");
    List result = await fetchExerciseDataService.fetchExeDataByMuscles(k,variable.Muscles);
     for (int i = 0; i < result.length; i++) {
       if (result[i]['difficulty'] == 'intermediate' ||
           result[i]['difficulty'] == 'expert') {
         exeData.add(result[i]['name']);
       }
     }

    } else {
      int k = ((i + 1) ~/ 2);
      print("k2 is $k");
      List result = await fetchExerciseDataService.fetchExeDataByMuscles(k,variable.Muscles);
      for (int i = 0; i < result.length; i++) {
        if (result[i]['difficulty'] == 'intermediate' ||
            result[i]['difficulty'] == 'beginner') {
          exeData.add(result[i]['name']);
        }
      }
      }
     return exeData;
  }
Future<List> getExercisesLists(int i) async{
  isLoading=true;
  notifyListeners();
  List result= await fetchExerciseDataService.fetchExeDataByMuscles(i,variable.Muscles);
  for(int i=0;i<result.length;i++){
    exeList.add(result[i]["name"]);

  }
  isLoading=false;
 // notifyListeners();
  //print(exeList);
  return exeList;
}
Future<List> getExercisesData(String exercise) async{
  isLoading=true;
  notifyListeners();
  List result= (await fetchExerciseDataService.fetchExeData(exercise));
  //print(result[0]);
  isLoading=false;
  notifyListeners();
  return result;
}
  void addtoFavourites(String workoutName, int i) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString('favWorkoutId$i',workoutName );
    print("In remove from favourites ${preferences.getStringList('favourites')}");

  }
  void removefromFavourites(String workoutName,int i) async{

    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove('favWorkoutId$i');
    print("In remove from favourites ${preferences.getStringList('favourites')}");

  }






}
import 'package:bmi_app/Services/FetchYogaDataService.dart';
import 'package:flutter/cupertino.dart';
class YogaDataProvider with ChangeNotifier{
  FetchYogaDataService fetchYogaDataService=FetchYogaDataService();
  late List yogaData;
  Map poseData={};
  var result;
  List yogaPoses=[];

  Future<List> getYogaData() async{
  yogaData=await fetchYogaDataService.fetchYogaData();
  return yogaData;
  }
  List getYogaPoses(int i){
    for(int j=0;j<(yogaData[i]['poses']).length;j++){
        yogaPoses.add(yogaData[i]['poses'][j]['english_name']);
        print("yogaPoses is $yogaPoses");
    }
    print(yogaPoses);
    return yogaPoses;
  }
  clearYogaPoses(){
    yogaPoses.clear();
  }
  Future<Map> getYogaPoseData(String poseName) async{
     Map poseData=await fetchYogaDataService.fetchPoseData(poseName);
    print("in provider $poseData");
    return poseData;
  }

  notifyListeners();
  }

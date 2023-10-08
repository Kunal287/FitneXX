import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';

import '../Services/FetchHealthDataService.dart';

class HealthDataProvider with ChangeNotifier{
  FetchHealthDataService fetchHealthDataService=FetchHealthDataService();
  List bmiData=[];
  List THRData=[];
  getbmiData(String height, String weight) async{
   Map data = await fetchHealthDataService.fetchBMIData(height,weight);
    bmiData.add(data['bmi']);
    bmiData.add(data['height']);
    bmiData.add(data['weight']);
    bmiData.add(data['weight_status']);
    notifyListeners();
    print(bmiData);
  }
  void clearAll() {
    bmiData.clear();
    THRData.clear();
    notifyListeners();
  }
  getHeartRateData(String age, String fitness_level) async{
    Map data = await fetchHealthDataService.fetchTHRData(age,fitness_level);
    THRData.add(data['thr_max']);
    THRData.add(data['thr_min']);
    notifyListeners();
    print(THRData);
  }
}
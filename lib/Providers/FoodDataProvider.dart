
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class FoodDataProvider with ChangeNotifier{

  List nutritionData=[];
  String food="1lb brisket with fries";
  List foodName=[];
  List foodCalories=[];
  List foodProtein=[];

  fetchFoodNutritonData(String queryText) async {
    Map<String, String> queryParams = {
      'query': queryText,
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var res = await http.get(Uri.parse(
        'https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?$queryString'),
        headers: {
          'X-RapidAPI-Key': '158fdcad67msh4b459a69f046d74p184385jsn58f1c0bdbb20',
          'X-RapidAPI-Host': 'nutrition-by-api-ninjas.p.rapidapi.com'
        }
    );
    print(res);
    nutritionData = json.decode(res.body.toString());
    print("data is $nutritionData");

    notifyListeners();
  }
  void clearAll(){
    //foodName.clear();
    //foodCalories.clear();
    notifyListeners();
  }
  notifyListeners();
}
import 'dart:convert';

import 'package:http/http.dart'as http;
class FetchHealthDataService {
  Map data={};
  static bool error=false;
  Future<Map> fetchBMIData(String height, String weight) async {
    try{
      var res = await http.get(Uri.parse(
          'https://health-calculator-api.p.rapidapi.com/bmi?height=${height}&weight=${weight}'),
          headers: {
            'X-RapidAPI-Key': 'bacdb6e0b4msh456047722155848p18fbc9jsnb01bf462a38b',
            'X-RapidAPI-Host': 'health-calculator-api.p.rapidapi.com'
          }
      );
      data = json.decode(res.body.toString());
      error=false;
    }catch(e){
      error=true;
    }



    return data;
  }
  Future<Map> fetchTHRData(String age, String fitness_level) async {
    try{
      var res = await http.get(Uri.parse(
          'https://health-calculator-api.p.rapidapi.com/thr?age=${age}&fitness_level=${fitness_level}'),
          headers: {
            'X-RapidAPI-Key': 'bacdb6e0b4msh456047722155848p18fbc9jsnb01bf462a38b',
            'X-RapidAPI-Host': 'health-calculator-api.p.rapidapi.com'
          }

      );
      data = json.decode(res.body.toString());
      error=false;
    }catch(e){
      error=true;
    }

    return data;
  }
}
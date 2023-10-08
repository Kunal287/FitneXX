import 'dart:convert';

import 'package:http/http.dart'as http;
class FetchExerciseDataService {
  static bool error=false;
  List data=[];
  Future<List> fetchExeDataByMuscles(int k,Map Muscles) async {
    List fetchedExeData = [];

    try{
      var res = await http.get(Uri.parse(
          'https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises?muscle=${Muscles['Day$k']}'),
          headers: {
            'X-RapidAPI-Key': 'bacdb6e0b4msh456047722155848p18fbc9jsnb01bf462a38b',
            'X-RapidAPI-Host': 'exercises-by-api-ninjas.p.rapidapi.com'
          }

      );
      print(res.body);
      data = json.decode(res.body.toString());
      error=false;
    }catch(e){
      print(e);
      error=true;

    }
    print('error is $error');

    return data;
  }
  Future<List> fetchExeData(String exercise) async {
    print(exercise);
    try{
      var res = await http.get(Uri.parse(
          'https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises?name=$exercise'),
          headers: {
            'X-RapidAPI-Key': 'bacdb6e0b4msh456047722155848p18fbc9jsnb01bf462a38b',
            'X-RapidAPI-Host': 'exercises-by-api-ninjas.p.rapidapi.com'
          }
      );
      data = json.decode(res.body.toString());
      error=false;
    }catch(e){
      error=true;
      print(e);
    }
    print('error is $error');

    return data;
  }

}
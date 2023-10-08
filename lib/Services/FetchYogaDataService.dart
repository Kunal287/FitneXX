import 'dart:convert';
import 'package:http/http.dart'as http;
class FetchYogaDataService{
  Future<List> fetchYogaData() async{
    var res=await http.get(Uri.parse('https://yoga-api-nzy4.onrender.com/v1/categories'),);
    if(res.statusCode==200){
      final yogaData=json.decode(res.body.toString());
      return yogaData;
    }else{
      return [];
    }
  }
  Future<Map> fetchPoseData(String poseName) async{
    var res=await http.get(Uri.parse('https://yoga-api-nzy4.onrender.com/v1/poses?name=$poseName'),);
    if(res.statusCode==200){
      Map poseData=json.decode(res.body.toString());

      print("In service poseData is $poseData");
      try{
        return poseData;
      }catch(e){
        print("error is $e");
        return {};
      }

    }else{
      return {};
    }
  }

}
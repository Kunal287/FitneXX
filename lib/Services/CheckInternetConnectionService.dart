
import 'dart:io';

import 'package:http/http.dart' as http;
class CheckInternetConnection{
  static bool isConnected=false;
  Future<bool> checkInternetConnection() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected=true;
      }
    } on SocketException catch (_) {
      isConnected=false;
    }
    print(isConnected);
    return isConnected;
  }
}
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier{
  late bool isLoggedin=true;
  setCredentials(String email) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('Email', email.trim());
  }


}
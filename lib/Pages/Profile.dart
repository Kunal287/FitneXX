import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Profile extends StatefulWidget{
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String phoneNumber='';
  void initState(){
   getPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child:Center(
          child: Column(
              children: [
                SizedBox(height: 50),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                SizedBox(height: 50),
                Text('Name:- ${FirebaseAuth.instance.currentUser!.displayName}',style: TextStyle(color: Colors.white,fontSize: 25),),
                SizedBox(height: 20),
                Text('Email:- ${FirebaseAuth.instance.currentUser!.email}',style: TextStyle(color: Colors.white,fontSize: 25),),
                SizedBox(height: 20),
                Text('Phone Number:- $phoneNumber',style: TextStyle(color: Colors.white,fontSize: 25),),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    }

  void getPhoneNumber() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      phoneNumber=prefs.getString('${FirebaseAuth.instance.currentUser!.email}')!;
    });

  }

}
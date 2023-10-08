

import 'dart:math';

import 'package:bmi_app/Pages/Login.dart';
import 'package:bmi_app/Pages/Home.dart';
import 'package:bmi_app/Pages/Profile.dart';
import 'package:bmi_app/Providers/AuthenticationProvider.dart';
import 'package:bmi_app/Pages/WorkoutList.dart';
import 'package:bmi_app/Pages/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Exercises.dart';
import 'Favourites.dart';

class Dashboard extends StatefulWidget{
  var loginStatus;
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }

}

class _DashboardState extends State<Dashboard>{
  LoginPage l1=LoginPage();
  late final int tab;
  int _page = 1;

  final screens = [Favourites(),HomePage(),Profile()];
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  String emailID="xyz";
  void initState() {
    super.initState();
    print(FirebaseAuth.instance.currentUser);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthenticationProvider>(context,listen: false).isLoggedin=true;
    });

    Firebase.initializeApp();
    checkLoggingStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle:true ,
          title: const Text("Dashboard"),
          //backgroundColor:Color.fromRGBO(37, 32, 36, 1),
          backgroundColor:Colors.black,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: () { print("pressed on notification"); }, icon: Icon(Icons.notifications),),
            ),
          ],


        ),
        drawer:Drawer(

            backgroundColor:Colors.black,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
              ),
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: CircleAvatar(
                            radius: 30,

                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Kunal Joshi",
                            style: TextStyle(fontSize: 20, color: Colors.white)),
                        Text(emailID,
                            style: TextStyle(fontSize: 20, color: Colors.white)),
                      ],
                    ),
                  ),
                  const Divider(
                      height:50,thickness: .06, color: Color.fromARGB(255,30,29,29)),
                  ListTile(
                    iconColor: Colors.white,
                    leading: const Icon(Icons.person),
                    title: const Text('Daily Excercises',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Exercises()));
                    },
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    leading: const Icon(Icons.book),
                    title: const Text('Calories Counter',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      // Add Navigation logic here
                    },
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    leading: const Icon(Icons.subscriptions),
                    title: const Text('Go Premium',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      // Add Navigation logic here
                    },
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    leading: const Icon(Icons.subscriptions),
                    title: const Text('Sign Out',
                        style: TextStyle(color: Colors.white)),
                    onTap: () async{
                      FirebaseAuth.instance.signOut();
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      prefs.setString('Email',"");
                      Provider.of<AuthenticationProvider>(context,listen: false).isLoggedin=false;
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                  ),
                ],
              ),
            )
        ),
       bottomNavigationBar:Container(
          color: Colors.black,
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
           child: GNav(
                     backgroundColor:Colors.black,
                     color: Colors.white,
                     activeColor: Color.fromRGBO(255, 0, 0, 1),

                     tabBackgroundColor: Colors.grey.shade800,
                     selectedIndex: _page,
                     onTabChange:(index){
                       setState(() {
                         _page = index;
                       });
                     },
                     padding: EdgeInsets.all(16.0),
                     gap: 8,
                     tabs: const [
                       GButton(icon: CupertinoIcons.heart ,text: "favourites",iconColor: Colors.white,textColor: Color.fromRGBO(255, 0, 0, 1)),
                       GButton(icon:CupertinoIcons.home,text: "Home",iconColor: Colors.white,textColor: Color.fromRGBO(255, 0, 0, 1)),
                       GButton(icon:CupertinoIcons.person,text: "Profile",iconColor: Colors.white,textColor: Color.fromRGBO(255, 0, 0, 1)),
                     ],

                   ),
         ),
       ),
      body: Center(child: screens[_page])
      );
  }
  checkLoggingStatus() async{
    SharedPreferences pref=await SharedPreferences.getInstance();

    setState(() {
      widget.loginStatus=pref.getBool('isLoggedIn');
      print("loginStatus is $widget.loginStatus");
      emailID=FirebaseAuth.instance.currentUser!.email!;
    });
  }
}
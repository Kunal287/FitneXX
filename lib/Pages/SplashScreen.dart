import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bmi_app/Pages/Dashboard.dart';
import 'package:bmi_app/Providers/AuthenticationProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'Login.dart';
class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _SplashScreenState();
  }

}

class _SplashScreenState extends State<SplashScreen>{
    void initState(){

    super.initState();

    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();

  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
         duration: 3000,
         splash:( new Image.asset('assets/images/logo.png')),
         splashIconSize: double.maxFinite,
         centered: true,
         nextScreen: Provider.of<AuthenticationProvider>(context).isLoggedin!=true ?LoginPage(): Dashboard(),
         splashTransition: SplashTransition.slideTransition,
         pageTransitionType: PageTransitionType.leftToRight,
         backgroundColor: Colors.white);
  }

}
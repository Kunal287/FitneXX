import 'package:bmi_app/Pages/Dashboard.dart';
import 'package:bmi_app/Providers/AuthenticationProvider.dart';
import 'package:bmi_app/Pages/YogaDataProvider.dart';
import 'package:bmi_app/Pages/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import '../Providers/ExercisesDataProvider.dart';
import '../Providers/HealthDataProvider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  SharedPreferences prefs =await SharedPreferences.getInstance();
  List workout=[];
  prefs.setStringList('favourites',workout.cast<String>());
  runApp(MainPage(prefs:prefs,));
}

class MainPage extends StatelessWidget {
  SharedPreferences prefs;
  MainPage({required this.prefs});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: YogaDataProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ExercisesDataProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AuthenticationProvider(),
          child: SplashScreen(),
        ),
        ChangeNotifierProvider.value(
          value: HealthDataProvider(),
        ),
      ],
      child: MaterialApp(
         title: "BMI APP",
         home: AnimatedSplashScreen(
             duration: 3000,
             splash:( new Image.asset('assets/images/logo.png')),
             splashIconSize: double.maxFinite,
             centered: true,
             nextScreen: prefs.getString('Email')==""?LoginPage(): Dashboard(),
             splashTransition: SplashTransition.slideTransition,
             pageTransitionType: PageTransitionType.leftToRight,
             backgroundColor: Colors.white)
    )
    );
  }



}


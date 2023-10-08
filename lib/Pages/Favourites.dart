import 'dart:math';

import 'package:bmi_app/Constraints/ListVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DisplayExerciseData.dart';
class Favourites extends StatefulWidget{

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  ListVariables variable=ListVariables();
  Random rd=Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
        ],
      ),
    );
  }
}
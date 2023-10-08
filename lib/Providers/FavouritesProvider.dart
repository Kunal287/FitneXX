import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesProvider with ChangeNotifier{
  List favourites=[];
  addtoFavourites(String workoutName) async{
    favourites.add(workoutName);
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setStringList('favourites',favourites as List<String>);
    print("In add to favourites ${preferences.getStringList('favourites')}");
  }
  removefromFavourites(String workoutName) async{
    favourites.remove(workoutName);
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setStringList('favourites',favourites as List<String>);
    print("In remove from favourites ${preferences.getStringList('favourites')}");
  }
}
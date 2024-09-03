import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/model/restaurant_model.dart';

/* method to load restaurant data from the local file
 
  returns - list of restaurant class objects
*/
Future<List<RestaurantModel>> loadData() async {
  final fileData = await rootBundle.loadString('assets/restaurants.json');

  final List<dynamic> jsonData = json.decode(fileData);

  return jsonData.map((json) => RestaurantModel.fromJson(json)).toList();
}

//riverpod state provider
final restaurantProvider = FutureProvider<List<RestaurantModel>>((ref) async {
  return loadData();
});

//search bar state provider
final searchBarProvider = StateProvider<String>((ref) => '');

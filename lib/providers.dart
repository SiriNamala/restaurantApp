import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/model/restaurant_model.dart';

//method to load restaurant data from the local file
Future<List<RestaurantModel>> loadData() async {
  final fileData = await rootBundle.loadString('assets/restaurants.json');

  final List<dynamic> jsonData = json.decode(fileData);

  return jsonData.map((json) => RestaurantModel.fromJson(json)).toList();
}

final restaurantProvider = FutureProvider<List<RestaurantModel>>((ref) async {
  return loadData();
});

final searchBarProvider = StateProvider<String>((ref) => '');

//restaurant class model
class RestaurantModel {
  int id;
  String name;
  String cuisine;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.cuisine,
  });

/* factory constructor
    Param - json data
    returns a new restaurant object
*/
  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'],
    );
  }
}

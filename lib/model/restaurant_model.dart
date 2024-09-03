class RestaurantModel {
  int id;
  String name;
  String cuisine;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.cuisine,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'],
    );
  }
}

class Ingredient {
  String title;
  int id;
  String image;
  int services;

  Ingredient({
    required this.image,
    required this.title,
    required this.id,
    required this.services,
  });

  factory Ingredient.fromJson(Map<String, dynamic> jsonData) {
    return Ingredient(
      image: jsonData["image"],
      title: jsonData["title"],
      id: jsonData["id"],
      services: jsonData["servings"],
    );
  }
}

class Model {
  String title;
  int id;
  String image;

  Model({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Model.fromJson(Map<String, dynamic> jsonData) {
    return Model(
      id: jsonData["id"],
      title: jsonData["title"],
      image: jsonData["image"],
    );
  }
}

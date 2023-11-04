import 'package:recipes/models/mydatabase.dart';

class ModelDataBase {
  int? id;
  late String title;
  late String image;



  ModelDataBase({required this .id,required this.title ,required this.image});
  ModelDataBase.fromMap(Map<String, dynamic> map) {
    if (map[recipeId] != null) id = map[recipeId];
    title = map[recipeTitle];
    image= map[recipeImage];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (id != null) map[recipeId] = id;
    map[recipeTitle] = title;
    map[recipeImage] = image;

    return map;
  }
}
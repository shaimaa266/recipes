import 'package:recipes/models/model.dart';

class Recipes {
  final List<Model> recipes;

  Recipes({required this.recipes});

  factory Recipes.fromJson(Map<String, dynamic> jsonData) {
    List<Model> recipeList = (jsonData["results"] as List)
        .map((item) => Model.fromJson(item))
        .toList();
    return Recipes(recipes: recipeList);
  }
}

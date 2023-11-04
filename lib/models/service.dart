import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipes/models/recipes.dart';

class FoodApi {
  Future<List<Recipes>> fetchAllRecipes() async {
    try {
      final response = await http.get(Uri.parse('https://api.spoonacular.com/recipes/complexSearch'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Recipes recipes = Recipes.fromJson(data);
        return [recipes]; // Wrap the single recipe in a list for consistency
      } else {
        print("Failed to fetch recipes - ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<List<Recipes>> fetchByIngredient() async {
    try {
      final response = await http.get(Uri.parse('https://api.spoonacular.com/recipes/716429/information?includeNutrition=false'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Recipes recipes = Recipes.fromJson(data);
        return [recipes]; // Wrap the single recipe in a list for consistency
      } else {
        print("Failed to fetch recipes by ingredient - ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeDetailPage extends StatefulWidget {

  final int recipeId;
  final String title;
  final String image;

  RecipeDetailPage({required this.recipeId, required this.title, required this.image});




  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  String title = '';
  String image = '';
  List<String> ingredients = [];

  @override
  void initState() {
    super.initState();
    fetchRecipeDetails();
  }

  Future<void> fetchRecipeDetails() async {
    final apiKey = 'YOUR_SPOONACULAR_API_KEY'; // Replace with your API key
    final response = await http.get(
      Uri.parse(
          'https://api.spoonacular.com/recipes/${widget.recipeId}/information?includeNutrition=false&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      title = data['title'];
      image = data['image'];
      ingredients = (data['extendedIngredients'] as List)
          .map((ingredient) => ingredient['originalString'].toString())
          .toList();

      setState(() {}); // Update the UI with fetched data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Detail"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white10,
      ),
      body: Column(
        children: [
          Image.network(image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(ingredients[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

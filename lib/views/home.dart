import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recipes/views/info.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> recipes = [];

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final apiKey = 'YOUR_SPOONACULAR_API_KEY'; // Replace with your API key
    final response = await http.get(
      Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&number=10',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;

      setState(() {
        recipes = results.map((result) => {
          'id': result['id'],
          'title': result['title'],
          'image': result['image'],
        }).toList();
      });
    } else {
      print('Failed to load recipes - Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Recipe"),
        centerTitle: true,
        actions: [
          Icon(Icons.search, color: Colors.teal),
        ],
        elevation: 0,
        backgroundColor: Colors.white10,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailPage(
                    recipeId: recipe['id'],
                    title: recipe['title'],
                    image: recipe['image'],
                  ),
                ),
              );
            },
            child: Container(
              width: 250,
              height: 150,
              child: Column(
                children: [
                  Image.network(recipe['image']),
                  Text(recipe['title']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

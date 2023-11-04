import 'package:flutter/material.dart';

import 'package:recipes/models/database_model.dart';
import 'package:recipes/models/mydatabase.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<ModelDataBase> mylist = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteRecipes();
  }

  Future<void> fetchFavoriteRecipes() async {
    final myDatabase = MyDataBase.instance;
    await myDatabase.open();
    mylist = await myDatabase.getAllTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: mylist.length,
        itemBuilder: (context, index) {
          ModelDataBase modelDataBase = mylist[index];
          return ListTile(
            leading: Container(
              height: 250,
              width: 100,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(modelDataBase.image),
              ),
            ),
            title: Text(
              modelDataBase.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}

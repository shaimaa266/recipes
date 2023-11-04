import 'package:path/path.dart';
import 'package:recipes/models/database_model.dart';
import 'package:sqflite/sqflite.dart';

final String recipeId = 'id';
final String recipeTitle = 'title';
final String recipeImage = 'image';
final String tableName="favourite ";

class MyDataBase {
  late Database db;

  static final MyDataBase instance = MyDataBase._internal();

  factory MyDataBase() {
    return instance;
  }

  MyDataBase._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'todos.db'),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute('''
create table $tableName ( 
  $recipeId integer primary key autoincrement, 
  $recipeTitle text not null,
  $recipeImage  text not null,
 

  )
''');
        });
  }

  Future<ModelDataBase> insertTodo(ModelDataBase modelDataBase) async {
    modelDataBase.id = await db.insert(tableName, modelDataBase.toMap());
    return modelDataBase;
  }

  Future<int> updateRecipe(ModelDataBase modelDataBase) async {
    return await db.update(tableName, modelDataBase.toMap(),
        where: '$recipeId = ?', whereArgs: [modelDataBase.id]);
  }

  Future<int> deleteRecipe(int id) async {
    return await db.delete(tableName, where: '$recipeId = ?', whereArgs: [id]);
  }

  Future<List<ModelDataBase>> getAllTodo() async {
    List<Map<String, dynamic>> todoMaps = await db.query(tableName);
    if (todoMaps.length == 0)
      return [];
    else {
      List<ModelDataBase> todos = [];
      for (var element in todoMaps) {
        todos.add(ModelDataBase.fromMap(element));
      }
      return todos;
    }
  }

  Future close() async => db.close();
}
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseService {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE favourites(
        workout TEXT
      );
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Favourites.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> addToFavourites(String workoutName) async {
    final db = await DatabaseService.db();
    print(db);
    final data = {'workout': workoutName};
    print(data);
    final id = await db.insert('favourites', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print("id is $id");
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getFavourites() async {
    final db = await DatabaseService.db();
    return db.query('favourites');
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<bool> checkIfExistInFavourites(String workoutName) async {
    bool status=false;
    final db = await DatabaseService.db();
    Future<List<Map<String,dynamic>>> result =db.query('favourites', where: "workout?", whereArgs: [workoutName], limit: 1);
    result!=null?status=true:status=false;
    return status;
  }

  // Update an item by id

  // Delete
  static Future<void> removeFromFavourite(String workoutName) async {
    final db = await DatabaseService.db();
    try {
      await db.delete("favourites", where: "workout = ?", whereArgs: [workoutName]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
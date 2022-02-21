import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/task.dart';

class DatabaseHelper {
  // Future<Database> database() {
  //   return openDatabase(
  //     'todo.db',
  //     version: 1,
  //     onCreate: (Database db, int version) async {
  //       await db.execute(
  //         'CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
  //       );
  //       await db.execute(
  //         'CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, time TEXT, status INTEGER)',
  //       );
  //     },
  //   );
  // }

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
          // 'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, completed INTEGER, createdAt datetime, updatedAt datetime)',
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    Database db = await database();
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task task) async {
    Database db = await database();
    // await db.update(
    //   'tasks',
    //   task.toMap(),
    //   where: 'id = ?',
    //   whereArgs: [task.id],
    // );
    await db.rawUpdate(
      'UPDATE tasks SET title = ?, description = ? WHERE id = ?',
      [task.title, task.description, task.id],
    );
  }

  Future<void> updateTaskTitle(int? id, String title) async {
    Database db = await database();
    await db.rawUpdate(
      'UPDATE tasks SET title = ? WHERE id = ?',
      [title, id],
    );
  }

  Future<void> updateDescription(String description, int? id) async {
    Database db = await database();
    await db.rawUpdate(
      'UPDATE tasks SET description = ? WHERE id = ?',
      [description, id],
    );
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (i) {
      return Task(
        id: taskMap[i]['id'],
        title: taskMap[i]['title'],
        description: taskMap[i]['description'],
      );
    });
  }
}

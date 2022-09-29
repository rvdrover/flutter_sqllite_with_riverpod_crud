import 'package:flutter_sqllite_crud/models/personal_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as pth;

class Services {
  static Future<Database> createTable() async {
    String databasesPath = await getDatabasesPath();
    final path = pth.join(databasesPath, "persons.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE person(id INTEGER PRIMARY KEY AUTOINCREMENT,first_name TEXT,last_name TEXT)');
    });
  }

  static Future<List<PersonalModal>> fetchData() async {
    final db = await Services.createTable();
    List<Map<String, dynamic>> slist = await db.query('person');
    return slist.map((e) => PersonalModal.fromJson(e)).toList();
  }

  static Future addPerson(String firstName, String lastName) async {
    final db = await Services.createTable();
    return db.insert(
        'person',
        PersonalModal(
          firstname: firstName,
          lastname: lastName,
        ).toMap());
  }

  static Future updatePerson(int id, String firstname, String lastname) async {
    final db = await Services.createTable();
    return db.update(
        'person',
        PersonalModal(
          id: id,
          firstname: firstname,
          lastname: lastname,
        ).toMap(),
        where: "id=?",
        whereArgs: [id]);
  }

  static Future deletePerson(int id) async {
    final db = await Services.createTable();
    return db.delete('person', where: "id=?", whereArgs: [id]);
  }
}

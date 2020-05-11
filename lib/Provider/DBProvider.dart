import 'dart:io';

import 'package:EmploiNC/Model/Emploi.dart';
import 'package:EmploiNC/Model/EmploiSQLITE.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'EmploiSQLITE_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE EmploiSQLITE('
              'id INTEGER PRIMARY KEY,'
              'titreOffre TEXT,'
              'typeContrat TEXT,'
              'logo TEXT,'
              'nomEntreprise TEXT,'
              'aPourvoirLe TEXT,'
              'communeEmploi TEXT,'
              'url TEXT UNIQUE'
              ')');
        });
  }

  // Insert emplois on database
  createEmploi(EmploiSQLITE newEmploiSQLITE) async {
    //await deleteAllEmploiSQLITE();
    final db = await database;
    final res = await db.insert('EmploiSQLITE', newEmploiSQLITE.toJson());

    return res;
  }

  // Delete all emplois
  Future<int> deleteAllEmploiSQLITE() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM EmploiSQLITE');

    return res;
  }

  Future<List<Emploi>> getAllEmploiSQLITE() async {
    print("---------------------------------------------------\n");
    print("SELECT_ALL");
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM EmploiSQLITE ORDER BY url DESC");
    print("2"+res.toList().toString());
    print("res.isNotEmpty :"+res.isNotEmpty.toString());
    List<Emploi> list =
    res.isNotEmpty ? res.map((c) => Emploi.fromJson(c)).toList() : [];
    print("---------------------------------------------------\n");

    return list;
  }
}
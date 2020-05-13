import 'dart:io';

import 'package:EmploiNC/Model/Emploi.dart';
import 'package:EmploiNC/Model/EmploiSQLITE.dart';
import 'package:EmploiNC/Model/Favory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'EmploiSQLITE_api_provider.dart';

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
              'isFav TEXT,'
              'titreOffre TEXT,'
              'shortnumeroOffre TEXT,'
              'typeContrat TEXT,'
              'logo TEXT,'
              'datePublication TEXT,'
              'nomEntreprise TEXT,'
              'aPourvoirLe TEXT,'
              'communeEmploi TEXT,'
              'url TEXT UNIQUE'
              ')');
          await db.execute('CREATE TABLE favories('
              'id INTEGER PRIMARY KEY,'
              'shortnumeroOffre TEXT'
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

  // Insert emplois on database
  createFavory(Favory fav) async {
    final db = await database;
    final res = await db.insert('favories', fav.toJson());

    return res;
  }

  // Delete all emplois
  Future<int> deleteAllEmploiSQLITE() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM EmploiSQLITE');

    return res;
  }

  Future<List<Emploi>> getAllEmploiSQLITE() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM EmploiSQLITE ORDER BY url DESC");
    List<Emploi> list =
    res.isNotEmpty ? res.map((c) => Emploi.fromJson(c)).toList() : null;
    return list;
  }

  Future<List<Emploi>> getAllFavEmploiSQLITE() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM EmploiSQLITE as E,favories as F WHERE E.shortnumeroOffre = F.shortnumeroOffre ORDER BY url DESC");
    List<Emploi> list =
    res.isNotEmpty ? res.map((c) => Emploi.fromJson(c)).toList() : null;

    return list;
  }


  Future<List<Favory>> isFav(String numeroOffre) async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM favories ORDER BY url DESC');
    List<Favory> list =
    res.isNotEmpty ? res.map((c) => Favory.fromJson(c)).toList() : null;
    return list;
  }

  updateisFav(String numeroOffre,String bool) async {
    final db = await database;
    if ( bool == "false") {
      await db.rawDelete('DELETE FROM favories WHERE shortnumeroOffre='+'"'+numeroOffre+'"');
    }
    await db.rawUpdate('UPDATE EmploiSQLITE SET isFav='+'"'+bool+'" WHERE shortnumeroOffre='+'"'+numeroOffre+'"');
    final res = await db.rawQuery('SELECT * FROM EmploiSQLITE WHERE shortnumeroOffre='+'"'+numeroOffre+'" ORDER BY url DESC');
  }
}
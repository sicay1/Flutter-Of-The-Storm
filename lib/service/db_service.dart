import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:hero_of_the_storm/models/hero.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;

class DbService {
  static final DbService _instance = new DbService.internal();
  factory DbService() => _instance;
  DbService.internal();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE Heroes('
        'name TEXT,'
        'short_name TEXT,'
        'attribute_id TEXT,'
        'translations TEXT,'
        'role BLOB,'
        'type BLOB,'
        'release_date BLOB,'
        'icon_url BLOB,'
        'abilities BLOB,'
        'talents BLOB'
        ')');
    print("Table [data] are created");
  }

  Future<void> addHeroes(Heroes hero) async {
    var dbClient = await db;
    await dbClient.insert('Heroes', hero.toMap());
  }

  Future<void> getFirstHeroInDb() async {
    var dbClient = await db;
    var resp = await dbClient.query('Heroes');
    int randomIndex = Random().nextInt(resp.length);
    print('Tables [HEROES] contain ${resp.length} records');
    Heroes he = Heroes.fromDb(resp[randomIndex]);
    print('getFirstHeroInDb ${he.toJson()}');
    print(' shotname ${he.iconUrl.the92X93}');
    
  }
}

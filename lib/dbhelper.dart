import 'package:flutter/material.dart';
import 'package:shopping_project/Model/cartModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cart2.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE cart2 (id INTEGER PRIMARY KEY, productId TEXT UNIQUE, productName TEXT, initialPrice INTEGER, productPrice INTEGER, quaintity INTEGER, unitTag TEXT, image TEXT)',
    );
  }

  Future<int> insert(Cart cart) async {
    Database dbClient = await db;
    return await dbClient.insert('cart2', cart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}

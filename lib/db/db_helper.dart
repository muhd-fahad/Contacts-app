import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/contact_model.dart';

class DbHelper {
  static Database? _database;
  static const String tableName = 'contacts';

  DbHelper._privateConstructor();

  static final DbHelper instance = DbHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'contact_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT
      )
    ''');
    debugPrint('Database table created successfully.');
  }

  // CRUD Operations

  // Insert
  Future<int> insertContact(Contact contact) async {
    final db = await instance.database;
    return await db.insert(
      tableName,
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // list / Get all Contacts
  Future<List<Contact>> getContacts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName  , orderBy: 'name ASC');// 'name DESC');

    return List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
    });
  }

  // Update
  Future<int> updateContact(Contact contact) async {
    final db = await instance.database;
    return await db.update(
      tableName, contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  // Delete
  Future<int> deleteContact(int id) async {
    final db = await instance.database;
    return await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id]);
  }
}

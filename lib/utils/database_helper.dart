import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutterappv14/models/note.dart';
import 'package:sqlitetoexcel/sqlitetoexcel.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colAltkategori = 'altkategori';
  String colDemirbaskategori = 'demirbaskategori';
  String colBarkod = 'barkod';
  String colPriority = 'priority';
  String colDate = 'date';



  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getExternalStorageDirectory();
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

 
void _createDb(Database db, int newVersion) async {
    var colDescription2 = colDescription;
        await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
            '$colDescription2 TEXT, $colAltkategori TEXT, $colDemirbaskategori TEXT, $colBarkod TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count = noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

  // Export All tables
  Future<String> exportAll() async {
    var excludes = new List<dynamic>();
    var prettify = new Map<dynamic, dynamic>();
    var finalpath = "";

    // Exclude column(s) from being exported
    // excludes.add("id");

    // Prettifies columns name
    prettify["id"] = "ID";
    prettify["title"] = "Başlık";
    prettify["description"] = "Açıklama";
    prettify["altkategori"] = "Altkategori";
    prettify["demirbaskategori"] = "Demirbaskategori";
    prettify["barkod"] = "Barkod";
    prettify["priority"] = "Öncelik";
    prettify["date"] = "Tarih";

    Directory directory = await getExternalStorageDirectory();
    String dbPath = directory.path + 'notes.db';
    try {
      finalpath = await Sqlitetoexcel.exportAll(dbPath, "documents", "", "Export All.xls", excludes, prettify);
      return finalpath;
    } on PlatformException catch (e) {
      print("exception" + e.message.toString());
    }
    return finalpath;
  }

  void showSnackBar(String message, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Your excel file is saved in ' + message),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: scaffoldKey.currentState.removeCurrentSnackBar,
      ),
    ));
  }
}
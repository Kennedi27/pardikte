import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/node_model.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    final path = join(await getDatabasesPath(), 'notes.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            encryptedContent TEXT,
            createdAt TEXT,
            updatedAt TEXT
          )
        ''');
      },
    );
    return _database!;
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert('notes', note.toMap());
    return note.copyWith(id: id);
  }

  Future<List<Note>> readAll() async {
    final db = await instance.database;
    final result = await db.query('notes', orderBy: 'updatedAt DESC');
    return result.map((map) => Note.fromMap(map)).toList();
  }

  // TODO: update & delete methods...
}

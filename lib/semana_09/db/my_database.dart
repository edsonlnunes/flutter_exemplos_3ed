import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  Database? _instance;

  static final MyDatabase _database = MyDatabase._internal();

  MyDatabase._internal();

  factory MyDatabase() {
    return _database;
  }

  Future<Database> getInstance() async {
    if (_instance == null) {
      _instance = await _openMyDatabase();
    }

    return _instance!;
  }

  Future<Database> _openMyDatabase() async {
    final pathDatabase = await getDatabasesPath();
    final nameDatabase = 'form_users.db';
    final database = await openDatabase(
      join(pathDatabase, nameDatabase),
      version: 11,
      onCreate: (db, version) async {
        print('versão $version');

        // await db.execute('''
        //   CREATE TABLE users(
        //     id INTEGER PRIMARY KEY AUTOINCREMENT,
        //     name TEXT,
        //     email TEXT,
        //     cep TEXT,
        //     adress TEXT,
        //     file_path TEXT
        //   );
        // ''');

        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            file_path TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE address(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cep TEXT,
            address TEXT,
            userid INTEGER NOT NULL,
            FOREIGN KEY(userid) REFERENCES users(id)
          );
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        print('oldVersion: $oldVersion');
        print('newVersion: $newVersion');

        // if (newVersion == 10) {
        //   db.execute('''
        //     CREATE TABLE address(
        //       id INTEGER PRIMARY KEY AUTOINCREMENT,
        //       cep TEXT,
        //       address TEXT,
        //       userid INTEGER NOT NULL,
        //       FOREIGN KEY(userid) REFERENCES users(id)
        //     );
        //   ''');
        // }
      },
    );

    return database;
  }
}

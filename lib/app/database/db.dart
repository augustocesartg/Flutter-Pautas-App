import 'package:path/path.dart';
import 'package:pautas_app/app/database/initial_script.dart';
import 'package:pautas_app/app/database/migration.dart';
import 'package:sqflite/sqflite.dart';

final initializationScript = initialScript;
final migrationScripts = migrationsScripts;

class DB {
  static Database db;
  String path;

  Future<void> mountDatabase() async {
    db = await _open();
  }

  Future<Database> _open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'pautas_app_db.db');

    return await openDatabase(path,
      version: migrationScripts.length + 1,
      onCreate: (Database db, int version) async {
        initializationScript.forEach((script) async => await db.execute(script));  
        migrationScripts.forEach((script) async => await db.execute(script));
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (var i = oldVersion - 1; i < newVersion - 1; i++) {
          await db.execute(migrationScripts[i]);
        }
      }
    );
  }
}
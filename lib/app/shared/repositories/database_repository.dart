import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas_app/app/database/db.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class DatabaseRepository<T> extends Disposable {
  String tableName;
  Database database;

  DatabaseRepository() {
    _extractTableName(T);
    _getDatabase();
  }

  _getDatabase() {
    database = DB.db;
  }

  _extractTableName(Type type) {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    tableName = T
        .toString()
        .replaceAllMapped(exp, (Match m) => ('_' + m.group(0)))
        .toLowerCase();
  }

  Future<int> insert(Map<String, dynamic> row) async {
    return await database.insert(tableName, row);
  }

  Future<int> update(Map<String, dynamic> row, {String idName = 'id'}) async {
    return await database.update(
      tableName,
      row,
      where: idName + ' = ?',
      whereArgs: [row[idName]],
    );
  }

  Future<void> delete(int id, {String idName = 'id'}) async {
    await database.delete(
      tableName,
      where: idName + ' = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    await database.rawDelete('DELETE FROM $tableName');
  }

  Future<List<Map<String, dynamic>>> findAll() async {
    return await database.query(tableName);
  }

  Future<Map> findById(int id, {String idName = 'id'}) async {
    List<Map> maps = await database.query(
      tableName,
      where: idName + ' = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }

  Map<String, dynamic> trimAllStrings(Map<String, dynamic> object) {
    return object.map((key, value) {
      if (value is String) {
        return MapEntry(key, value.trim());
      }
      return MapEntry(key, value);
    });
  }

  @override
  void dispose() {}
}

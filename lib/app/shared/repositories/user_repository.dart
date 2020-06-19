import 'package:pautas_app/app/shared/model/user_model.dart';
import 'package:pautas_app/app/shared/repositories/database_repository.dart';

class UserRepository extends DatabaseRepository<UserModel> {
  @override
  Future<int> insert(Map<String, dynamic> row) async {
    return super.insert(trimAllStrings(row));
  }

  @override
  Future<int> update(Map<String, dynamic> row, {String idName = 'id'}) async {
    return super.update(trimAllStrings(row));
  }

  Future<List<UserModel>> findAllUser() async {
    return (await super.findAll())
        .map((json) => UserModel.fromJson(json))
        .toList();
  }

  Future<UserModel> findByEmailAndPassword(
      String email, String password) async {
    List<Map> maps = await database.query(
      tableName,
      where: 'email = ? and password = ?',
      whereArgs: [email, password],
    );
    if (maps.length > 0) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }

  Future<UserModel> findByEmail(
      String email) async {
    List<Map> maps = await database.query(
      tableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.length > 0) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }
}

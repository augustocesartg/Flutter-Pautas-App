import 'package:pautas_app/app/shared/model/guideline_model.dart';
import 'package:pautas_app/app/shared/repositories/database_repository.dart';

class GuidelineRepository extends DatabaseRepository<GuidelineModel> {
  @override
  Future<int> insert(Map<String, dynamic> row) async {
    return super.insert(trimAllStrings(row));
  }

  @override
  Future<int> update(Map<String, dynamic> row, {String idName = 'id'}) async {
    return super.update(trimAllStrings(row));
  }

  Future<List<GuidelineModel>> findAllGuideline() async {
    return (await super.findAll())
        .map((json) => GuidelineModel.fromJson(json))
        .toList();
  }

  Future<List<GuidelineModel>> findByStatusAndUserId(
      int status, int userId) async {
    return (await database.query(
      tableName,
      where: 'status = ? and userId = ?',
      whereArgs: [status, userId],
    ))
        .map((json) => GuidelineModel.fromJson(json))
        .toList();
  }
}

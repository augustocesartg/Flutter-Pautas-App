import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas_app/app/database/db.dart';
import 'package:pautas_app/app/shared/sharedpreferences/shared_pref.dart';
import 'package:pautas_app/app/shared/sharedpreferences/shared_pref_keys.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final DB db = DB();

  @observable
  DatabaseState databaseState = DatabaseState.LOADING;

  @action
  setDatabaseState(DatabaseState state) {
    this.databaseState = state;
  }

  @observable
  bool sessionActive = false;

  @action
  setSessionActive(bool sessionActive) => this.sessionActive = sessionActive;

  startDatabase() async {
    this.setDatabaseState(DatabaseState.LOADING);
    
    await db.mountDatabase();
    await Future.delayed(Duration(seconds: 3));

    Map<String, dynamic> session =
        await SharedPref.read(SharedPrefKeys.SESSION_KEY);
    setSessionActive(session != null);

    this.setDatabaseState(DatabaseState.IDLE);
  }
}

enum DatabaseState { LOADING, IDLE }

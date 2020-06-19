import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas_app/app/shared/model/guideline_model.dart';
import 'package:pautas_app/app/shared/model/user_model.dart';
import 'package:pautas_app/app/shared/repositories/guideline_repository.dart';
import 'package:pautas_app/app/shared/sharedpreferences/shared_pref.dart';
import 'package:pautas_app/app/shared/sharedpreferences/shared_pref_keys.dart';

part 'guidelines_controller.g.dart';

class GuidelinesController = _GuidelinesControllerBase
    with _$GuidelinesController;

abstract class _GuidelinesControllerBase with Store {
  final GlobalKey<ScaffoldState> guidelinesScaffoldKey =
      GlobalKey<ScaffoldState>();
  final GuidelineRepository _guidelineRepository = Modular.get();

  @observable
  GuidelinesState guidelinesState = GuidelinesState.IDLE;
  @action
  setGuidelinesState(GuidelinesState state) => this.guidelinesState = state;

  @observable
  ObservableList<GuidelineModel> guidelinesOpenList = ObservableList.of([]);

  @observable
  ObservableList<GuidelineModel> guidelinesCloseList = ObservableList.of([]);

  @observable
  UserModel user;
  @action
  setUser(UserModel user) => this.user = user;

  Future<void> init() async {
    Map<String, dynamic> session =
        await SharedPref.read(SharedPrefKeys.SESSION_KEY);
    setUser(UserModel.fromJson(session));

    await loadOpenGuidelines();
    await loadCloseGuidelines();
  }

  Future<void> loadOpenGuidelines() async {
    guidelinesOpenList = ObservableList.of(
        await _guidelineRepository.findByStatusAndUserId(0, user.id));
  }

  Future<void> loadCloseGuidelines() async {
    guidelinesCloseList = ObservableList.of(
        await _guidelineRepository.findByStatusAndUserId(1, user.id));
  }

  Future<void> closeGuideline(GuidelineModel guideline) async {
    guideline.changeStatus(1);
    await _guidelineRepository.update(guideline.toJson());
    await loadOpenGuidelines();
    await loadCloseGuidelines();
  }

  Future<void> reopenGuideline(GuidelineModel guideline) async {
    guideline.changeStatus(0);
    await _guidelineRepository.update(guideline.toJson());
    await loadOpenGuidelines();
    await loadCloseGuidelines();
  }

  Future<void> register() async {
    await Modular.to.pushNamed(
      '/home/registerguideline',
      arguments: user,
    );
    await loadOpenGuidelines();
  }

  Future<void> logout() async {
    await SharedPref.remove(SharedPrefKeys.SESSION_KEY);
    Modular.to.pushReplacementNamed('/auth');
  }
}

enum GuidelinesState { LOADING, IDLE }

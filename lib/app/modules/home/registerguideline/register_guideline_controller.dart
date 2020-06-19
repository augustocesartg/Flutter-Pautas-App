import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas_app/app/shared/model/guideline_model.dart';
import 'package:pautas_app/app/shared/model/user_model.dart';
import 'package:pautas_app/app/shared/repositories/guideline_repository.dart';
import 'package:pautas_app/app/shared/utils/string_utils.dart';

part 'register_guideline_controller.g.dart';

class RegisterGuidelineController = _RegisterGuidelineControllerBase
    with _$RegisterGuidelineController;

abstract class _RegisterGuidelineControllerBase with Store {
  final GlobalKey<ScaffoldState> registerScaffoldKey =
      GlobalKey<ScaffoldState>();
  final GuidelineRepository _guidelineRepository = Modular.get();

  @observable
  GuidelineModel guideline = GuidelineModel();
  @action
  setGuideline(GuidelineModel guideline) => this.guideline = guideline;

  @observable
  RegisterFormState registerFormState = RegisterFormState.IDLE;
  @action
  setRegisterFormState(RegisterFormState state) =>
      this.registerFormState = state;

  Future<void> init(UserModel user) async {
    guideline.changeAuthor(user.name);
    guideline.changeUserId(user.id);
    guideline.changeStatus(0);
    setGuideline(guideline);
  }

  @computed
  bool get isValid {
    return validateTitle() == null &&
        validateDescription() == null &&
        validateDetails() == null;
  }

  String validateTitle() {
    if (StringUtils.isNullOrEmpty(guideline.title)) {
      return 'Campo obrigatório';
    }

    return null;
  }

  String validateDescription() {
    if (StringUtils.isNullOrEmpty(guideline.description)) {
      return 'Campo obrigatório';
    }

    return null;
  }

  String validateDetails() {
    if (StringUtils.isNullOrEmpty(guideline.details)) {
      return 'Campo obrigatório';
    }

    return null;
  }

  Future<void> save() async {
    try {
      setRegisterFormState(RegisterFormState.LOADING);
      await _guidelineRepository.insert(guideline.toJson());
      registerScaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Pauta cadastrada com sucesso!'),
        ),
      );
      await Future.delayed(Duration(seconds: 2));
      Modular.to.pop();
      setRegisterFormState(RegisterFormState.IDLE);
    } catch (e) {
      registerScaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Não foi possível cadastrar a pauta! Tente novamente.'),
        ),
      );
      setRegisterFormState(RegisterFormState.IDLE);
    }
  }
}

enum RegisterFormState { LOADING, IDLE }

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas_app/app/shared/model/user_model.dart';
import 'package:pautas_app/app/shared/repositories/user_repository.dart';
import 'package:pautas_app/app/shared/utils/email_utils.dart';
import 'package:pautas_app/app/shared/utils/string_utils.dart';
part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final GlobalKey<ScaffoldState> registerScaffoldKey =
      GlobalKey<ScaffoldState>();
  final UserRepository _userRepository = Modular.get();

  UserModel user = UserModel();

  @observable
  RegisterFormState registerFormState = RegisterFormState.IDLE;
  @action
  setRegisterFormState(RegisterFormState state) =>
      this.registerFormState = state;

  @computed
  bool get isValid {
    return validateName() == null &&
        validateEmail() == null &&
        validatePassword() == null;
  }

  String validateName() {
    if (StringUtils.isNullOrEmpty(user.name)) {
      return 'Campo obrigatório';
    }

    return null;
  }

  String validateEmail() {
    if (StringUtils.isNullOrEmpty(user.email)) {
      return 'Campo obrigatório';
    }

    if (!EmailUtils.isValid(user.email)) {
      return "Email inválido";
    }

    return null;
  }

  String validatePassword() {
    if (StringUtils.isNullOrEmpty(user.password)) {
      return 'Campo obrigatório';
    }

    return null;
  }

  Future<void> save() async {
    try {
      setRegisterFormState(RegisterFormState.LOADING);
      await _userRepository.insert(user.toJson());
      registerScaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Usuário cadastrado com sucesso!'),
        ),
      );
      await Future.delayed(Duration(seconds: 2));
      Modular.to.pop();
      setRegisterFormState(RegisterFormState.IDLE);
    } catch (e) {
      registerScaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Não foi possível cadastrar o usuário! Tente novamente.'),
        ),
      );
      setRegisterFormState(RegisterFormState.IDLE);
    }
  }
}

enum RegisterFormState { LOADING, IDLE }

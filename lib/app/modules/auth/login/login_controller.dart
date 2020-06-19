import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas_app/app/shared/model/user_model.dart';
import 'package:pautas_app/app/shared/repositories/user_repository.dart';
import 'package:pautas_app/app/shared/sharedpreferences/shared_pref.dart';
import 'package:pautas_app/app/shared/sharedpreferences/shared_pref_keys.dart';
import 'package:pautas_app/app/shared/utils/string_utils.dart';
import 'package:pautas_app/email.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  final UserRepository _userRepository = Modular.get();

  @observable
  LoginState loginState = LoginState.IDLE;
  @action
  setLoginState(LoginState state) => this.loginState = state;

  @observable
  String email;
  @action
  setEmail(String email) => this.email = email;

  @observable
  String password;
  setPassword(String password) => this.password = password;

  Future<void> login() async {
    try {
      setLoginState(LoginState.LOADING);
      if (StringUtils.isNullOrEmpty(email) ||
          StringUtils.isNullOrEmpty(password)) {
        loginScaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Usuário e senha são obrigatórios!'),
          ),
        );
      }

      UserModel user = await _userRepository.findByEmailAndPassword(
        email,
        password,
      );

      if (user != null) {
        SharedPref.save(SharedPrefKeys.SESSION_KEY, user);
        Modular.to.pushReplacementNamed('/home');
      } else {
        setLoginState(LoginState.IDLE);
        loginScaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Usuário não cadastrado!'),
          ),
        );
      }
    } catch (e) {
      setLoginState(LoginState.IDLE);
      loginScaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Não foi posível fazer login! Tente novamente.'),
        ),
      );
    }
  }

  Future<void> forgetPassword() async {
    try {
      if (StringUtils.isNullOrEmpty(email)) {
        loginScaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Informe seu email.'),
          ),
        );
        return;
      }

      UserModel user = await _userRepository.findByEmail(email);

      if (user != null) {
        Email mail = Email();
        await mail.sendMessage(
          'Sua senha: ${user.password}',
          'augustocesartg@gmail.com',
          'Pautas App',
        );

        loginScaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Verifique seu email.'),
          ),
        );
      } else {
        setLoginState(LoginState.IDLE);
        loginScaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Usuário não cadastrado!'),
          ),
        );
      }
    } catch (e) {
      loginScaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Não foi possível recuerar senha.'),
        ),
      );
    }
  }
}

enum LoginState { LOADING, IDLE }

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas_app/app/app_controller.dart';
import 'package:pautas_app/app/app_widget.dart';
import 'package:pautas_app/app/modules/auth/login/login_controller.dart';
import 'package:pautas_app/app/modules/auth/register/register_controller.dart';
import 'package:pautas_app/app/modules/home/guidelines/guidelines_controller.dart';
import 'package:pautas_app/app/modules/home/registerguideline/register_guideline_controller.dart';
import 'package:pautas_app/app/modules/pages_module.dart';
import 'package:pautas_app/app/shared/repositories/guideline_repository.dart';
import 'package:pautas_app/app/shared/repositories/user_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => LoginController()),
        Bind((i) => RegisterController()),
        Bind((i) => UserRepository()),
        Bind((i) => GuidelinesController()),
        Bind((i) => GuidelineRepository()),
        Bind((i) => RegisterGuidelineController()),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: PagesModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

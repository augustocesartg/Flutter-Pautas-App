import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas_app/app/modules/auth/login/login_page.dart';
import 'package:pautas_app/app/modules/auth/register/register_page.dart';

class AuthModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => LoginPage()),
        Router('/register', child: (_, args) => RegisterPage()),
      ];

  static Inject get to => Inject<AuthModule>.of();
}

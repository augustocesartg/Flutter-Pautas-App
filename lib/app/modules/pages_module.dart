import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas_app/app/modules/auth/auth_module.dart';
import 'package:pautas_app/app/modules/home/home_module.dart';

class PagesModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/auth', module: AuthModule()),
        Router('/home', module: HomeModule()),
      ];

  static Inject get to => Inject<PagesModule>.of();
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas_app/app/modules/home/guidelines/guidelines_page.dart';
import 'package:pautas_app/app/modules/home/registerguideline/register_guideline_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => GuidelinesPage()),
        Router('/registerguideline', child: (_, args) => RegisterGuidelinePage(user: args.data)),
      ];

  static Inject get to => Inject<HomeModule>.of();
}

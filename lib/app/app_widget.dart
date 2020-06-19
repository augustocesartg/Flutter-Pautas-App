import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas_app/app/app_controller.dart';
import 'package:pautas_app/app/splash.dart';

class AppWidget extends StatefulWidget {
  AppWidget({Key key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AppController appController = Modular.get();

  @override
  void initState() {
    appController.startDatabase();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (appController.databaseState == DatabaseState.LOADING) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Splash(),
          );
        }

        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MaterialApp(
            navigatorKey: Modular.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Pautas App',
            // theme: myTheme,
            initialRoute: appController.sessionActive ? '/home' : '/auth',
            onGenerateRoute: Modular.generateRoute,
          ),
        );
      },
    );
  }
}
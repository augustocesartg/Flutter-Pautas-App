import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas_app/app/modules/auth/login/login_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: controller.loginScaffoldKey,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment,
                          color: Colors.blue,
                          size: 48,
                        ),
                        Text(
                          'Pautas App',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Usuário'),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: controller.setEmail,
                  ),
                  SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(labelText: 'Senha'),
                    onChanged: controller.setPassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 36),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: controller.login,
                          padding: EdgeInsets.all(16),
                          color: Colors.blue,
                          child: Observer(
                            builder: (_) {
                              return (controller.loginState ==
                                      LoginState.LOADING)
                                  ? Container(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                          Theme.of(context).buttonColor,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Entrar',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: controller.forgetPassword,
                        child: Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Modular.to.pushNamed('/auth/register'),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

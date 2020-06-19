import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas_app/app/modules/auth/register/register_controller.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState
    extends ModularState<RegisterPage, RegisterController> {
  _textField(
      {String labelText,
      onChange,
      String Function() errorText,
      bool obscureText,
      TextInputType keyboardType}) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText == null ? null : errorText(),
      ),
      onChanged: onChange,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.registerScaffoldKey,
      appBar: AppBar(
        title: Text('Cadastro'),
        actions: <Widget>[
          Observer(
            builder: (context) {
              return RaisedButton(
                onPressed: controller.isValid ? controller.save : null,
                color: Colors.blue,
                child:
                    (controller.registerFormState == RegisterFormState.LOADING)
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
                            'Salvar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(12),
            child: Observer(
              builder: (_) => Column(
                children: <Widget>[
                  _textField(
                    labelText: 'Nome',
                    onChange: controller.user.changeName,
                    errorText: controller.validateName,
                  ),
                  SizedBox(height: 24),
                  _textField(
                    labelText: 'Email',
                    onChange: controller.user.changeEmail,
                    errorText: controller.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  _textField(
                    labelText: 'Senha',
                    onChange: controller.user.changePassword,
                    errorText: controller.validatePassword,
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

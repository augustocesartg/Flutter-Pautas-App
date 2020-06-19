import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas_app/app/modules/home/registerguideline/register_guideline_controller.dart';
import 'package:pautas_app/app/shared/model/user_model.dart';

class RegisterGuidelinePage extends StatefulWidget {
  final UserModel user;
  RegisterGuidelinePage({Key key, this.user}) : super(key: key);

  @override
  _RegisterGuidelinePageState createState() => _RegisterGuidelinePageState();
}

class _RegisterGuidelinePageState
    extends ModularState<RegisterGuidelinePage, RegisterGuidelineController> {

  @override
  void initState() {
    controller.init(widget.user);
    super.initState();
  }

  _textField(
      {String labelText,
      onChange,
      String Function() errorText,
      bool obscureText = false,
      TextInputType keyboardType = TextInputType.text,
      int maxLines = 1,
      String initialValue,
      bool enabled = true}) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText == null ? null : errorText(),
      ),
      onChanged: onChange,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      controller: initialValue != null ? TextEditingController(text: initialValue) : null,
      enabled: enabled,
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
                    labelText: 'Título',
                    onChange: controller.guideline.changeTitle,
                    errorText: controller.validateTitle,
                  ),
                  SizedBox(height: 24),
                  _textField(
                    labelText: 'Descrição',
                    onChange: controller.guideline.changeDescription,
                    errorText: controller.validateDescription,
                  ),
                  SizedBox(height: 24),
                  _textField(
                    labelText: 'Detalhes',
                    onChange: controller.guideline.changeDetails,
                    errorText: controller.validateDetails,
                    maxLines: 3,
                  ),
                  SizedBox(height: 24),
                  _textField(
                    labelText: 'Autor',
                    initialValue: widget.user.name,
                    enabled: false,
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

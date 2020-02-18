import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ctrl_money/login/repositories/auth_respository.dart';
import 'package:ctrl_money/login/stores/auth_store.dart';
import 'package:ctrl_money/shared/services/auth_service.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:ctrl_money/shared/utils/validators.dart';
import 'package:ctrl_money/signup/repositories/signup_repository.dart';
import 'package:ctrl_money/signup/stores/signup_store.dart';
import 'package:ctrl_money/shared/components/date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _signUpKey;
  SignUpStore _signUpStore;
  AuthStore _authStore;

  @override
  void initState() {
    _signUpKey = GlobalKey<FormState>();
    _authStore = AuthStore(AuthRepository(CustomDio()), AuthStorage());
    _signUpStore = SignUpStore(SignUpRepository(CustomDio()));
    reaction((_) => _signUpStore.request.status, (_) async {
      FutureStatus status = _signUpStore.request.status;
      if (status == FutureStatus.fulfilled) {
        _authStore.loginDto.username = _signUpStore.dto.email;
        _authStore.loginDto.password = _signUpStore.dto.password;
        await _authStore.login();
      } else if (status == FutureStatus.rejected) {
        print(_signUpStore.request.error);
        _showError(_signUpStore.request.error.toString());
      }
    });

    reaction((_) => _authStore.response.status, (_) {
      FutureStatus status = _authStore.response.status;
      if (status == FutureStatus.fulfilled) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (status == FutureStatus.rejected) {
        _showError(_authStore.response.error);
      }
    });

    super.initState();
  }

  _showError(String error) {
    String _message = error;
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            body: Center(
              child: Text(_message),
            ),
            tittle: "Opa!",
            btnOkColor: Colors.redAccent,
            btnOkOnPress: () {})
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darker,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: lighter,
        title: Text("Crie sua conta"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Icon(FontAwesomeIcons.chartLine,
                  size: 100, color: secondaryBlue),
            ),
            Text("Controle melhor seus gastos",
                style: TextStyle(color: secondaryText, fontSize: 20)),
            Padding(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _signUpKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (e) => _signUpStore.dto.email = e,
                      style: TextStyle(color: secondaryText),
                      keyboardType: TextInputType.emailAddress,
                      validator: (e) => validateEmail(e),
                      decoration: InputDecoration(
                          labelText: "E-mail",
                          prefixIcon: Icon(FontAwesomeIcons.solidEnvelope)),
                    ),
                    SizedBox(height: 5),
                    Observer(
                      builder: (_) {
                        return TextFormField(
                          onSaved: (e) => _signUpStore.dto.password = e,
                          obscureText: !_signUpStore.visiblePassword,
                          style: TextStyle(color: secondaryText),
                          validator: (e) => validatePassword(e),
                          decoration: InputDecoration(
                              labelText: "Senha",
                              suffixIcon: IconButton(
                                icon: Icon(FontAwesomeIcons.solidEye),
                                onPressed: () => _signUpStore.visiblePassword =
                                    !_signUpStore.visiblePassword,
                              ),
                              prefixIcon: Icon(FontAwesomeIcons.lock)),
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(color: secondaryText),
                      validator: (e) => e.length < 3 || e.isEmpty
                          ? "Digite um nome válido"
                          : null,
                      onSaved: (e) => _signUpStore.dto.name = e,
                      decoration: InputDecoration(
                          labelText: "Nome",
                          prefixIcon: Icon(FontAwesomeIcons.solidUser)),
                    ),
                    SizedBox(height: 5),
                    DateTextFormField(
                      onValidate: (date) {
                        _signUpStore.dto.birthdate = date.toString();
                      },
                      validator: ((date) {
                        if (date.compareTo(DateTime.parse('2010-01-01')) < 0) {
                          return true;
                        }
                        return false;
                      }),
                      labelFail: "Data inválida",
                      decoration: InputDecoration(
                          labelText: "Data de nascimento",
                          suffixIcon: null,
                          prefixIcon: Icon(FontAwesomeIcons
                              .solidCalendar)), // Decoration to the widget
                      showDatePicker: false,

                      dateFormat: 'dd/mm/yyyy',
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2010),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width - 50,
              child: FlatButton(
                onPressed: () async {
                  if (_signUpKey.currentState.validate()) {
                    _signUpKey.currentState.save();
                    await _signUpStore.add();
                  }
                },
                color: blue,
                textColor: primaryText,
                child: Observer(
                  builder: (_) {
                    if (_signUpStore.request.status == FutureStatus.pending) {
                      return FadingText('Carregando...');
                    }
                    return Text('Prosseguir');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

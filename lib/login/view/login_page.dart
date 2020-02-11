import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:ctrl_money/home/views/home_page.dart';
import 'package:ctrl_money/login/repositories/auth_respository.dart';
import 'package:ctrl_money/login/stores/auth_store.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:ctrl_money/shared/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthStore _authStore;
  GlobalKey<FormState> _authKey;

  @override
  void initState() {
    _authStore = AuthStore(authRepository: AuthRepository(CustomDio()));
    _authKey = GlobalKey<FormState>();
    super.initState();

    reaction((_) => _authStore.response.status, (_) {
      if (_authStore.response.status == FutureStatus.rejected) {
        _showError(_authStore.response.result);
      } else if (_authStore.response.status == FutureStatus.fulfilled) {
        //Get.until('/', HomePage());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
      }
    });
  }

  _showError(Map<String, dynamic> error) {
    String _message = error['message'];
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Ctrl ",
                                style: TextStyle(
                                    fontFamily: GoogleFonts.lato().fontFamily,
                                    fontSize: 50,
                                    color: primaryText,
                                    fontWeight: FontWeight.w900)),
                            Text("Pay",
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.fredokaOne().fontFamily,
                                    fontSize: 50,
                                    color: primaryText,
                                    shadows: [
                                      Shadow(color: blue, blurRadius: 4)
                                    ],
                                    fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15),
                      Form(
                        key: _authKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              onSaved: (e) => _authStore.loginDto.username = e,
                              style: TextStyle(color: secondaryText),
                              validator: (e) => validateEmail(e),
                              decoration: InputDecoration(
                                  labelText: "E-mail",
                                  prefixIcon:
                                      Icon(FontAwesomeIcons.solidEnvelope)),
                            ),
                            SizedBox(height: 15),
                            Observer(
                              builder: (_) {
                                return TextFormField(
                                  onSaved: (e) =>
                                      _authStore.loginDto.password = e,
                                  style: TextStyle(color: secondaryText),
                                  obscureText: !_authStore.visiblePassword,
                                  validator: (e) => validatePassword(e),
                                  decoration: InputDecoration(
                                      labelText: "Senha",
                                      suffixIcon: IconButton(
                                        icon: Icon(_authStore.visiblePassword
                                            ? FontAwesomeIcons.solidEyeSlash
                                            : FontAwesomeIcons.solidEye),
                                        onPressed: () =>
                                            _authStore.visiblePassword =
                                                !_authStore.visiblePassword,
                                      ),
                                      prefixIcon: Icon(FontAwesomeIcons.lock)),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          CircularCheckBox(
                              value: true,
                              activeColor: blue,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              onChanged: (e) => e),
                          Text(
                            'Me manter conectado',
                            style: TextStyle(color: primaryText, fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          padding: EdgeInsets.all(15),
                          color: blue,
                          textColor: primaryText,
                          child: Observer(
                            builder: (_) {
                              return _authStore.response.status ==
                                      FutureStatus.pending
                                  ? FadingText('Carregando...')
                                  : Text("Entrar");
                            },
                          ),
                          onPressed: () async {
                            if (_authKey.currentState.validate()) {
                              _authKey.currentState.save();
                              await _authStore.login();
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Text("Não possui uma conta? ",
                              style: TextStyle(
                                  color: secondaryText, fontSize: 15)),
                          Text("Crie aqui.",
                              style: TextStyle(
                                  color: blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800)),
                        ],
                      )
                    ],
                  ))),
        ));
  }
}

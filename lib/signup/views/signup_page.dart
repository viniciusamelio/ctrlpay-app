import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shape_of_view/shape_of_view.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _signUpKey;

  @override
  void initState() {
    _signUpKey = GlobalKey<FormState>();
    super.initState();
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
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[          
          Positioned(
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width - 50,
              child: FlatButton(
                onPressed: () {},
                color: blue,
                textColor: primaryText,
                child: Text('Prosseguir'),
              ),
            ),
            bottom: 30,
          ),
          Positioned(
            top: 20,
            child: Container(
              child: Icon(FontAwesomeIcons.chartLine, size: 100, color: secondaryBlue),
            ),
          ),
          Positioned(
            top: 135,
            child: Text("Controle melhor seus gastos",
                style: TextStyle(color: secondaryText, fontSize: 20)),
          ),          
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 130,
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _signUpKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "E-mail",
                          prefixIcon: Icon(FontAwesomeIcons.solidEnvelope)),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Senha",
                          prefixIcon: Icon(FontAwesomeIcons.lock)),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Nome",
                          prefixIcon: Icon(FontAwesomeIcons.solidUser)),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Data de nascimento",
                        prefixIcon: Icon(FontAwesomeIcons.solidCalendarAlt),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),          
        ],
      ),
    );
  }
}

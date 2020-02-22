import 'dart:convert';

import 'package:ctrl_money/shared/models/user.dart';
import 'package:ctrl_money/shared/repositories/user_repository.dart';
import 'package:ctrl_money/shared/services/auth_service.dart';
import 'package:ctrl_money/shared/stores/user_store.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:ctrl_money/shared/utils/masks.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserStore _userStore;
  User _user;

  @override
  initState() {
    _userStore = UserStore(UserRepository(CustomDio()), AuthStorage());
    _user = User.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darker,
      appBar: AppBar(
        backgroundColor: darker,
        elevation: 0,
        title: Text("Minha conta",
            style: TextStyle(color: primaryText, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: _user.data.avatar != null
                    ? ClipOval(
                        child: Image.memory(base64Decode(_user.data.avatar),
                            fit: BoxFit.contain),
                      )
                    : CircleAvatar(
                        backgroundColor: lighter,
                        child: Icon(
                          FontAwesomeIcons.solidUser,
                          color: blue,
                        ),
                      ),
              ),
              title: Text("${_user.data.name}",
                  style: TextStyle(color: primaryText)),
              subtitle: Text("${_user.data.email}",
                  style: TextStyle(color: secondaryText)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                children: <Widget>[
                  FlatButton.icon(
                    color: secondaryBlue,
                    label: Text("Editar perfil",
                        style: TextStyle(color: primaryText)),
                    icon: Icon(
                      FontAwesomeIcons.solidEdit,
                      color: primaryText,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  FlatButton.icon(
                    color: secondaryLighter,
                    label: Text("Mudar senha",
                        style: TextStyle(color: primaryText)),
                    icon: Icon(FontAwesomeIcons.undo,
                        color: primaryText, size: 18),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Divider(color: secondaryText),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Dados da conta', style: TextStyle(color: primaryText, fontSize: 18)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.calendar_today, color: blue),
                SizedBox(width: 5,),
                Text("Cadastrado em: ", style: TextStyle(color: secondaryText,fontSize: 16),),
                Text('22/02/2020',style: TextStyle(color: secondaryBlue, fontSize: 15,fontWeight: FontWeight.w700))
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(FontAwesomeIcons.syncAlt, color: blue,),
                SizedBox(width: 5,),
                Text("Transações registradas: ", style: TextStyle(color: secondaryText,fontSize: 16),),
                Text('0',style: TextStyle(color: secondaryBlue, fontSize: 15,fontWeight: FontWeight.w700))
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(FontAwesomeIcons.bullseye, color: blue,),
                SizedBox(width: 5,),
                Text("Objetivos alcançados: ", style: TextStyle(color: secondaryText,fontSize: 16),),
                Text('0',style: TextStyle(color: secondaryBlue, fontSize: 15,fontWeight: FontWeight.w700))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

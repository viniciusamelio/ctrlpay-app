import 'dart:convert';

import 'package:ctrl_money/shared/models/user.dart';
import 'package:ctrl_money/shared/repositories/user_repository.dart';
import 'package:ctrl_money/shared/services/auth_service.dart';
import 'package:ctrl_money/shared/stores/user_store.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
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
        child: Column(children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Container(
              width: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: _user.data.avatar != null
                  ? ClipOval(
                      child: Image.memory(base64Decode(_user.data.avatar),
                          fit: BoxFit.fill),
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
                  label: Text("Editar avatar",
                      style: TextStyle(color: primaryText)),
                  icon: Icon(
                    FontAwesomeIcons.solidEdit,
                    color: primaryText,
                    size: 20,
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/profile/edit'),
                ),
                SizedBox(width: 10),
                FlatButton.icon(
                  color: secondaryLighter,
                  label:
                      Text("Mudar senha", style: TextStyle(color: primaryText)),
                  icon:
                      Icon(FontAwesomeIcons.undo, color: primaryText, size: 18),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Divider(color: secondaryText),
        ]),
      ),
    );
  }
}

import 'dart:convert';

import 'package:ctrl_money/login/repositories/auth_respository.dart';
import 'package:ctrl_money/login/stores/auth_store.dart';
import 'package:ctrl_money/profile/services/avatar_service.dart';
import 'package:ctrl_money/profile/stores/profile_store.dart';
import 'package:ctrl_money/shared/models/user.dart';
import 'package:ctrl_money/shared/repositories/user_repository.dart';
import 'package:ctrl_money/shared/services/auth_service.dart';
import 'package:ctrl_money/shared/stores/user_store.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  UserStore _userStore;
  User _user;
  GlobalKey<FormState> _profileEditKey;
  ProfileStore _profileStore;
  TextEditingController _nameController;
  AuthStore _authStore;

  @override
  initState() {
    _user = User.instance;
    _userStore = UserStore(UserRepository(CustomDio()), AuthStorage());
    _profileStore = ProfileStore(UserRepository(CustomDio()), AvatarService());
    _profileStore.userDto = _user.data;
    _userStore.user = _user.data;
    _profileEditKey = GlobalKey<FormState>();
    _authStore = AuthStore(AuthRepository(CustomDio()), AuthStorage());

    _nameController = TextEditingController(text: _userStore.user.name);

    reaction((_) => _profileStore.imagePickerRequest.status, (_) {
      FutureStatus status = _profileStore.imagePickerRequest.status;
      if (status == FutureStatus.fulfilled) {
        if (_profileStore.imagePickerRequest.value != null) {
          _profileStore.avatar = _profileStore.imagePickerRequest.value;
          _profileStore.update();
        }
      }
    });

    reaction((_) => _profileStore.updateRequest.status, (_) {
      FutureStatus status = _profileStore.updateRequest.status;
      if (status == FutureStatus.fulfilled) {
        setState(() {
          _userStore.user.avatar = _profileStore.updateRequest.value.avatar;
        });
        _user.data.avatar = _profileStore.updateRequest.value.avatar;
        _user.data = _profileStore.userDto;
        _authStore.saveUser(_user.data);
        Flushbar(
          backgroundColor: secondaryBlue,
          title: "Atualização de avatar",
          message: "Seu avatar foi atualizado com sucesso!",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darker,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darker,
        title: Text('Editar avatar', style: TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _profileEditKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Observer(
                builder: (_) {
                  if (_profileStore.updateRequest.status ==
                      FutureStatus.pending) {
                    return Center(
                      child: Container(
                          height: 140,
                          width: 140,
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                            backgroundColor: blue,
                          )),
                    );
                  }
                  if (_userStore.user.avatar != null) {
                    return Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 140,
                        width: 140,
                        child: ClipOval(
                          child: Image.memory(base64Decode(_user.data.avatar),
                              fit: BoxFit.fill),
                        ),
                      ),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 140,
                          child: Icon(
                            FontAwesomeIcons.solidUser,
                            color: blue,
                            size: 90,
                          )),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              Observer(
                builder: (_) {
                  return _userStore.user.avatar != null
                      ? FlatButton.icon(
                          color: Colors.red[400],
                          icon: Icon(FontAwesomeIcons.trash, color: primaryText,),
                          onPressed: () {
                            _profileStore.userDto.avatar = null;
                            _profileStore.update(remove: true);
                          },
                          label: Text('Remover',
                              style: TextStyle(color: primaryText)),
                        )
                      : FlatButton.icon(
                          color: Colors.deepPurple,
                          label: Text("Selecionar"),
                          onPressed: () async =>
                              await _profileStore.getAvatar(),
                          icon: Icon(FontAwesomeIcons.solidImage),
                          textColor: primaryText,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

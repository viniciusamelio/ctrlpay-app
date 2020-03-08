import 'package:ctrl_money/account/repositories/bank_account_repository.dart';
import 'package:ctrl_money/account/stores/bank_account_store.dart';
import 'package:ctrl_money/shared/models/user.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  BankAccountStore _bankAccountStore;
  User _user;
  @override
  void initState() {
    _bankAccountStore = BankAccountStore(BankAccountRepository(CustomDio()));
    _user = User.instance;
    _bankAccountStore.list(_user.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darker,
      appBar: AppBar(
        backgroundColor: darker,
        elevation: 0,
        title: Text("Contas bancárias",
            style: TextStyle(color: primaryText, fontSize: 18)),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.sync),
              iconSize: 20,
              onPressed: () => _bankAccountStore.list(_user.data),
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: secondaryLighter)
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_bankAccountStore.listRequest.status == FutureStatus.fulfilled) {
            if (_bankAccountStore.listRequest.value.length == 0) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.exclamation,
                        size: 80,
                        color: Colors.orange[300],
                      ),
                      SizedBox(height: 15),
                      Container(
                        child: const Text(
                          'Você ainda não adicionou nenhuma conta bancária',
                          style: TextStyle(color: primaryText, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Aqui é onde elas aparecerão quando você as adicionar',
                          style: TextStyle(color: secondaryText, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          color: blue,
                          textColor: primaryText,
                          child: const Text('Adicione aqui',
                              style: TextStyle(fontSize: 16)),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
                itemCount: _bankAccountStore.listRequest.value.length,
                primary: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                        '${_bankAccountStore.listRequest.value[index].description}l',
                        maxLines: 1),
                    subtitle: Text(
                        'R\$ ${_bankAccountStore.listRequest.value[index].totalAmount}'),
                  );
                });
          }
          return ListView(
            children: <Widget>[
              ListTileShimmer(
                hasBottomBox: true,
                isDarkMode: false,
                isDisabledButton: true,
                hasCustomColors: true,
                colors: [secondaryBlue, secondaryText, blue],
              ),
              ListTileShimmer(
                hasBottomBox: true,
                isDarkMode: false,
                isDisabledButton: true,
                hasCustomColors: true,
                colors: [secondaryBlue, secondaryText, blue],
              ),
              ListTileShimmer(
                hasBottomBox: true,
                isDarkMode: false,
                isDisabledButton: true,
                hasCustomColors: true,
                colors: [secondaryBlue, secondaryText, blue],
              ),
              ListTileShimmer(
                hasBottomBox: true,
                isDarkMode: false,
                isDisabledButton: true,
                hasCustomColors: true,
                colors: [secondaryBlue, secondaryText, blue],
              ),
              ListTileShimmer(
                hasBottomBox: true,
                isDarkMode: false,
                isDisabledButton: true,
                hasCustomColors: true,
                colors: [secondaryBlue, secondaryText, blue],
              )
            ],
          );
        },
      ),
    );
  }
}

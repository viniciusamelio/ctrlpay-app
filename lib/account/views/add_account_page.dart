import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ctrl_money/account/repositories/bank_account_repository.dart';
import 'package:ctrl_money/account/stores/bank_account_store.dart';
import 'package:ctrl_money/shared/models/user.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:progress_indicators/progress_indicators.dart';

class AddAccountPage extends StatefulWidget {
  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  GlobalKey<FormState> _bankAccountKey;
  BankAccountStore _bankAccountStore;
  User _user;
  MoneyMaskedTextController _amountController;

  @override
  void initState() {
    _bankAccountStore = BankAccountStore(BankAccountRepository(CustomDio()));
    _bankAccountStore.listCategories();
    _bankAccountKey = GlobalKey<FormState>();
    _user = User.instance;
    _amountController = MoneyMaskedTextController();

    reaction((_) => _bankAccountStore.addRequest.status, (_) {
      FutureStatus status = _bankAccountStore.addRequest.status;
      if (status == FutureStatus.fulfilled) {
        _user.data.totalAmount += _bankAccountStore.addRequest.value.totalAmount;
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            body: Center(
              child: Text("Conta adicionada com sucesso!",
                  textAlign: TextAlign.justify),
            ),
            tittle: "Sucesso!",
            btnOkColor: Colors.green,
            btnOkOnPress: () {
              Navigator.pop(context);
              Navigator.pop(context,true);
            }).show();
      } else if (status == FutureStatus.rejected) {
        _showError(_bankAccountStore.addRequest.value.message);
      }
    });

    super.initState();
  }

  _showError(String error) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            body: Center(
              child: Text(error, textAlign: TextAlign.justify),
            ),
            tittle: "Opa!",
            btnOkColor: Colors.redAccent,
            btnOkOnPress: () {})
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darker,
        title: Text("Nova conta bancária",
            style: TextStyle(color: primaryText, fontSize: 18)),
      ),
      backgroundColor: darker,
      floatingActionButton: Observer(
        builder: (_) {
          if (_bankAccountStore.addRequest.status != FutureStatus.pending) {
            return FlatButton.icon(
              color: green,
              icon: Icon(FontAwesomeIcons.solidSave, color: darker),
              label: Text('Salvar',
                  style: TextStyle(color: darker, fontWeight: FontWeight.w700)),
              onPressed: () {
                if (_bankAccountStore.selectedBankAccountCategory != null) {
                  if (_bankAccountKey.currentState.validate()) {
                    _bankAccountKey.currentState.save();
                    _bankAccountStore.bankAccountDto.idBankAccountCategory =
                        _bankAccountStore.selectedBankAccountCategory.id;
                    _bankAccountStore.bankAccountDto.idUser = _user.data.id;
                    _bankAccountStore.add();
                  }
                } else {
                  _showError(
                      "Você precisa selecionar uma categoria de conta bancária");
                }
              },
            );
          } else {
            return FlatButton(
              onPressed: () {},
              child: FadingText('Carregando...', style: TextStyle(color: secondaryText)),
            );
          }
        },
      ),
      body: Observer(builder: (_) {
        if (_bankAccountStore.categoryListRequest.status ==
            FutureStatus.fulfilled) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Form(
                  key: _bankAccountKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(color: secondaryText),
                        onSaved: (e) =>
                            _bankAccountStore.bankAccountDto.description = e,
                        validator: (e) {
                          if (e.isEmpty)
                            return "Insira uma descrição para a conta";
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Descrição da conta",
                            suffixIcon:
                                Icon(FontAwesomeIcons.envelopeOpenText)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: secondaryText),
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        validator: (e) {
                          e = e.replaceAll('.', '').replaceAll(',', '.');
                          if (e.isEmpty ||
                              double.tryParse(e) == null ||
                              double.tryParse(e) < 0)
                            return "Insira um valor válido";
                        },
                        onSaved: (e) =>
                            _bankAccountStore.bankAccountDto.totalAmount =
                                double.parse(
                                    e.replaceAll('.', '').replaceAll(',', '.')),
                        decoration: InputDecoration(
                            prefix: Text('R\$ ',
                                style: TextStyle(color: secondaryText)),
                            labelText: "Saldo",
                            suffixIcon: Icon(FontAwesomeIcons.dollarSign)),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: lighter,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black54)),
                        child: DropdownButton(
                          focusColor: blue,
                          itemHeight: 50,
                          hint: Padding(
                            child: Text(
                                _bankAccountStore.selectedBankAccountCategory ==
                                        null
                                    ? 'Categoria da conta'
                                    : '${_bankAccountStore.selectedBankAccountCategory.description}',
                                style: TextStyle(color: secondaryText)),
                            padding: EdgeInsets.only(left: 14),
                          ),
                          underline: Container(),
                          isExpanded: true,
                          onChanged: (int index) {
                            _bankAccountStore.selectedBankAccountCategory =
                                _bankAccountStore
                                    .categoryListRequest.value[index - 1];
                            FocusScope.of(context).nextFocus();
                          },
                          items: _bankAccountStore.categoryListRequest.value
                              .map((e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Text('${e.description}'),
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return ListView(
          children: <Widget>[
            ListTileShimmer(
              isDisabledAvatar: true,
              hasBottomBox: true,
              isDarkMode: false,
              isDisabledButton: true,
              hasCustomColors: true,
              colors: [secondaryBlue, darker, blue],
            ),
            ListTileShimmer(
              isDisabledAvatar: true,
              hasBottomBox: true,
              isDarkMode: false,
              isDisabledButton: true,
              hasCustomColors: true,
              colors: [secondaryBlue, darker, blue],
            ),
            ListTileShimmer(
              isDisabledAvatar: true,
              hasBottomBox: true,
              isDarkMode: false,
              isDisabledButton: true,
              hasCustomColors: true,
              colors: [secondaryBlue, darker, blue],
            )
          ],
        );
      }),
    );
  }
}

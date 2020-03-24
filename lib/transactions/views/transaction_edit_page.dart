import 'package:ctrl_money/account/repositories/bank_account_repository.dart';
import 'package:ctrl_money/account/stores/bank_account_store.dart';
import 'package:ctrl_money/shared/models/transaction_dto.dart';
import 'package:ctrl_money/shared/models/user.dart';
import 'package:ctrl_money/shared/repositories/transaction_repository.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:ctrl_money/transactions/stores/transaction_store.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:progress_indicators/progress_indicators.dart';

class TransactionEditPage extends StatefulWidget {
  @override
  _TransactionEditPageState createState() => _TransactionEditPageState();
}

class _TransactionEditPageState extends State<TransactionEditPage> {
  TransactionStore _transactionStore;
  BankAccountStore _bankAccountStore;
  FlutterMoneyFormatter _amountFormatter;
  bool loaded = false;
  User _user;
  @override
  void initState() {
    _user = User.instance;
    _transactionStore = TransactionStore(TransactionRepository(CustomDio()));
    _bankAccountStore = BankAccountStore(BankAccountRepository(CustomDio()));
    reaction((_) => _transactionStore.updateRequest.status, (_) {
      if (_transactionStore.updateRequest.status == FutureStatus.fulfilled) {
        if (_transactionStore.dto.idTransactionType == 1) {
          _bankAccountStore.bankAccountDto.totalAmount -= _transactionStore.dto.amount;
          _user.data.totalAmount -= _transactionStore.dto.amount;
        } else {
          _bankAccountStore.bankAccountDto.totalAmount += _transactionStore.dto.amount;
          _user.data.totalAmount += _transactionStore.dto.amount;
        }
        _bankAccountStore.update();
        setState(() {
          _transactionStore.dto.status = 'Ok';
        });
        Flushbar(
          duration: Duration(seconds: 2),
          backgroundColor: blue,
          title: "Sucesso!",
          message: "Transação alterada",
          mainButton: FlatButton(
            onPressed: () => Navigator.popUntil(
              context,
              (route) => route.settings.name == '/account',
            ),
            child: Text("Sair",
                style:
                    TextStyle(color: primaryText, fontWeight: FontWeight.w600)),
          ),
        )..show(context);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!loaded) {
      final arguments = ModalRoute.of(context).settings.arguments as Map;
      _transactionStore.dto = arguments['transaction'];
      _bankAccountStore.bankAccountDto = arguments['bankAccount'];
      _amountFormatter = FlutterMoneyFormatter(
          amount: _transactionStore.dto.amount,
          settings: MoneyFormatterSettings(
              thousandSeparator: '.', decimalSeparator: ','));
      loaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: darker,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darker,
        title: Text('Transação',
            style: TextStyle(color: primaryText, fontSize: 18)),
      ),
      floatingActionButton:
          _transactionStore.dto.status.toUpperCase() == "PENDENTE"
              ? Observer(
                  builder: (_) {
                    if (_transactionStore.updateRequest.status !=
                        FutureStatus.pending) {
                      return Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          onPressed: () {
                            _transactionStore.dto.status = "Ok";
                            _transactionStore.update();
                          },
                          color: blue,
                          child: Text(
                            'Marcar status como OK',
                            style: TextStyle(
                                color: primaryText,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }
                    return FadingText("Carregando...",
                        style: TextStyle(color: secondaryText));
                  },
                )
              : Container(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: _transactionStore.dto.idTransactionType == 2
                      ? Colors.lightGreen
                      : Colors.redAccent,
                  borderRadius: BorderRadius.circular(4)),
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _transactionStore.dto.status.toUpperCase() == 'OK'
                        ? Icon(Icons.check, size: 35)
                        : Icon(Icons.close, size: 35),
                    Text(_transactionStore.dto.status,
                        style: TextStyle(
                            color: darker,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                title: Text(
                  '${_transactionStore.dto.category}',
                  style: TextStyle(color: darker, fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                    _transactionStore.dto.idTransactionType == 1
                        ? 'Despesa'
                        : 'Receita',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: Text(_amountFormatter.output.nonSymbol),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Criada em: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(_transactionStore.dto.createdAt))}',
                style:
                    TextStyle(color: primaryText, fontWeight: FontWeight.w600),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Última atualização: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(_transactionStore.dto.updatedAt ?? _transactionStore.dto.createdAt))}',
                style:
                    TextStyle(color: primaryText, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

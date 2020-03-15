import 'package:ctrl_money/account/repositories/bank_account_repository.dart';
import 'package:ctrl_money/account/stores/bank_account_store.dart';
import 'package:ctrl_money/shared/repositories/transaction_repository.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:progress_indicators/progress_indicators.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  BankAccountStore _bankAccountStore;
  bool _loaded = false;
  FlutterMoneyFormatter _amountFormatter, _earningFomatter, _expenseFormatter;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    _bankAccountStore = BankAccountStore(
      BankAccountRepository(CustomDio()),
    );

    when(
        (_) =>
            _bankAccountStore.currentTransactionAmountRequest.status ==
            FutureStatus.fulfilled, () {
      if (_bankAccountStore.currentTransactionAmountRequest.value != null) {
        _bankAccountStore.earning = _bankAccountStore
            .currentTransactionAmountRequest.value
            .where((element) => element.description == "Receita")
            .toList()[0]
            .totalAmount;
        _bankAccountStore.expense = _bankAccountStore
            .currentTransactionAmountRequest.value
            .where((element) => element.description == "Despesa")
            .toList()[0]
            .totalAmount;
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loaded) {
      final id = ModalRoute.of(context).settings.arguments as int;
      _bankAccountStore.get(id);
      _bankAccountStore.getCurrentTransactionAmount(id);
      _loaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darker,
        title: Observer(
          builder: (_) {
            if (_bankAccountStore.getRequest.status == FutureStatus.fulfilled &&
                _bankAccountStore.getRequest.value != null) {
              return Text(
                  '${_bankAccountStore.getRequest.value.accountDescription}',
                  style: TextStyle(
                      color: primaryText,
                      fontWeight: FontWeight.w700,
                      fontSize: 18));
            }
            return FadingText('Conta bancária',
                style: TextStyle(
                    color: primaryText,
                    fontWeight: FontWeight.w700,
                    fontSize: 18));
          },
        ),
      ),
      backgroundColor: darker,
      body: Observer(builder: (_) {
        if (_bankAccountStore.getRequest.status != FutureStatus.pending) {
          if (_bankAccountStore.getRequest.value != null) {
            _amountFormatter = FlutterMoneyFormatter(
                amount: _bankAccountStore.getRequest.value.totalAmount,
                settings: MoneyFormatterSettings(
                    decimalSeparator: ',', thousandSeparator: '.'));
            return SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Saldo atual',
                      style: TextStyle(color: secondaryText, fontSize: 18)),
                  Text('${_amountFormatter.output.nonSymbol}',
                      style: TextStyle(color: primaryText, fontSize: 22)),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 140,
                        width: 130,
                        decoration: BoxDecoration(
                            color: lighter,
                            borderRadius: BorderRadius.circular(2)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Receitas',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            Text('${_date.month}/${_date.year}',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            Icon(
                              FontAwesomeIcons.arrowDown,
                              color: Colors.green,
                              size: 35,
                            ),
                            Observer(
                              builder: (_) {
                                _earningFomatter = FlutterMoneyFormatter(
                                    amount: _bankAccountStore.earning,
                                    settings: MoneyFormatterSettings(
                                        thousandSeparator: '.',
                                        decimalSeparator: ','));
                                return Text(
                                    '${_earningFomatter.output.nonSymbol}',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600));
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 140,
                        width: 130,
                        decoration: BoxDecoration(
                            color: lighter,
                            borderRadius: BorderRadius.circular(2)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Despesas',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            Text('${_date.month}/${_date.year}',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            Icon(
                              FontAwesomeIcons.arrowDown,
                              color: Colors.redAccent,
                              size: 35,
                            ),
                            Observer(
                              builder: (_) {
                                _expenseFormatter = FlutterMoneyFormatter(
                                    amount: _bankAccountStore.expense,
                                    settings: MoneyFormatterSettings(
                                        thousandSeparator: '.',
                                        decimalSeparator: ','));
                                return Text(
                                    '${_expenseFormatter.output.nonSymbol}',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600));
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Últimas transações',
                      style: TextStyle(
                          color: primaryText,
                          fontWeight: FontWeight.w600,
                          fontSize: 20))
                ],
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(FontAwesomeIcons.solidFolderOpen,
                    color: Colors.redAccent, size: 80),
                SizedBox(height: 10),
                Text('Algo deu errado!',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                        fontSize: 22)),
                Text('Não conseguimos encontrar sua conta...',
                    style: TextStyle(
                        color: secondaryText,
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
              ],
            ),
          );
        }
        return ListView(
          children: <Widget>[
            ListTileShimmer(
              hasBottomBox: true,
              isDarkMode: false,
              isDisabledButton: true,
              hasCustomColors: true,
              colors: [secondaryBlue, lighter, blue],
            ),
            ListTileShimmer(
              hasBottomBox: true,
              isDarkMode: false,
              isDisabledButton: true,
              hasCustomColors: true,
              colors: [secondaryBlue, lighter, blue],
            ),
            ListTileShimmer(
              hasBottomBox: true,
              isDarkMode: false,
              isDisabledButton: true,
              hasCustomColors: true,
              colors: [secondaryBlue, lighter, blue],
            ),
            ListTileShimmer(
              hasBottomBox: true,
              isDarkMode: false,
              isDisabledButton: true,
              hasCustomColors: true,
              colors: [secondaryBlue, lighter, blue],
            ),
            ListTileShimmer(
              hasBottomBox: true,
              isDarkMode: false,
              isDisabledButton: true,
              hasCustomColors: true,
              colors: [secondaryBlue, lighter, blue],
            )
          ],
        );
      }),
    );
  }
}

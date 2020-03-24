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
  FlutterMoneyFormatter _amountFormatter,
      _earningFomatter,
      _expenseFormatter,
      _transactionAmountFormatter;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    _bankAccountStore = BankAccountStore(
      BankAccountRepository(CustomDio()),
    );

    when(
        (_) =>
            _bankAccountStore.getRequest.status == FutureStatus.fulfilled &&
            _bankAccountStore.getRequest.value != null, () {
      _bankAccountStore.bankAccountDto = _bankAccountStore.getRequest.value;
      _bankAccountStore
          .getCurrentTransactionAmount(_bankAccountStore.getRequest.value.id);
    });

    reaction((_) => _bankAccountStore.currentTransactionAmountRequest.status,
        (_) {
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
      _bankAccountStore.bankAccountDto.id = id;
      _bankAccountStore.get(id);
      _bankAccountStore.getBankAccountTransactions(id, limit: 3);
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
                  style: TextStyle(color: primaryText, fontSize: 18));
            }
            if (_bankAccountStore.getRequest.status == FutureStatus.rejected) {
              return Text('Ops!',
                  style: TextStyle(color: Colors.redAccent, fontSize: 18));
            }
            return FadingText('Conta bancária',
                style: TextStyle(color: primaryText, fontSize: 18));
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
                        child: Observer(builder: (_) {
                          if (_bankAccountStore
                                  .currentTransactionAmountRequest.status !=
                              FutureStatus.pending) {
                            return Column(
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
                                  FontAwesomeIcons.arrowUp,
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
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            ),
                          );
                        }),
                      ),
                      SizedBox(width: 20),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 140,
                        width: 130,
                        decoration: BoxDecoration(
                            color: lighter,
                            borderRadius: BorderRadius.circular(2)),
                        child: Observer(builder: (_) {
                          if (_bankAccountStore
                                  .currentTransactionAmountRequest.status !=
                              FutureStatus.pending) {
                            return Column(
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
                            );
                          }
                          return Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.redAccent));
                        }),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Observer(builder: (_) {
                    if (_bankAccountStore
                            .bankAccountTransactionsRequest.value !=
                        null) {
                      if (_bankAccountStore
                              .bankAccountTransactionsRequest.value.length >
                          0) {
                        return FlatButton(
                          color: green,
                          onPressed: () => Navigator.pushNamed(
                              context, '/transaction/add',
                              arguments: _bankAccountStore.bankAccountDto),
                          child: Text("Adicionar",
                              style: TextStyle(
                                  color: darker, fontWeight: FontWeight.w600)),
                        );
                      }
                    }
                    return Container();
                  }),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Últimas transações',
                          style: TextStyle(
                              color: primaryText,
                              fontWeight: FontWeight.w600,
                              fontSize: 20)),
                      Observer(
                        builder: (_) {
                          if (_bankAccountStore
                                  .bankAccountTransactionsRequest.status ==
                              FutureStatus.fulfilled) {
                            return _bankAccountStore
                                        .bankAccountTransactionsRequest
                                        .value
                                        .length >
                                    2
                                ? GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                        context, '/account/transactions',
                                        arguments: _bankAccountStore
                                            .bankAccountDto.id),
                                    child: Text('Ver todas',
                                        style: TextStyle(
                                            color: blue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                  )
                                : Container();
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Observer(
                    builder: (_) {
                      if (_bankAccountStore
                              .bankAccountTransactionsRequest.status ==
                          FutureStatus.fulfilled) {
                        if (_bankAccountStore
                                .bankAccountTransactionsRequest.value.length >
                            0) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: _bankAccountStore
                                  .bankAccountTransactionsRequest.value.length,
                              itemBuilder: (context, index) {
                                final item = _bankAccountStore
                                    .bankAccountTransactionsRequest
                                    .value[index];
                                _transactionAmountFormatter =
                                    FlutterMoneyFormatter(
                                        amount: item.amount,
                                        settings: MoneyFormatterSettings(
                                            thousandSeparator: '.',
                                            decimalSeparator: ','));
                                return Container(
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: item.idTransactionType == 2
                                          ? Colors.lightGreen
                                          : Colors.redAccent,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: ListTile(
                                    onTap: () => Navigator.pushNamed(
                                        context, '/transaction/edit',
                                        arguments: {
                                          "transaction": item,
                                          "bankAccount":
                                              _bankAccountStore.bankAccountDto
                                        }),
                                    leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        item.status.toUpperCase() == 'OK'
                                            ? Icon(Icons.check, size: 35)
                                            : Icon(Icons.close, size: 35),
                                        Text(item.status,
                                            style: TextStyle(
                                                color: darker,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    title: Text(
                                      '${item.category}',
                                      style: TextStyle(
                                          color: darker,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    subtitle: Text(
                                        item.idTransactionType == 1
                                            ? 'Despesa'
                                            : 'Receita',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    trailing: Text(_transactionAmountFormatter
                                        .output.nonSymbol),
                                  ),
                                );
                              });
                        }
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Icon(FontAwesomeIcons.solidFolderOpen,
                                  color: blue, size: 80),
                              const SizedBox(height: 10),
                              const Text(
                                  'Você ainda não possui transações nessa conta.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: secondaryText,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17)),
                              const SizedBox(height: 10),
                              FlatButton(
                                color: green,
                                child: Text('Comece a adicionar aqui!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: darker)),
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, '/transaction/add',
                                    arguments:
                                        _bankAccountStore.bankAccountDto),
                              )
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          backgroundColor: blue,
                        )),
                      );
                    },
                  )
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

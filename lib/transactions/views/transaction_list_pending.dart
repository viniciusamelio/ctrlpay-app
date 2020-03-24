import 'package:ctrl_money/shared/components/transaction_tile.dart';
import 'package:ctrl_money/shared/repositories/transaction_repository.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:ctrl_money/transactions/stores/transaction_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:mobx/mobx.dart';

class TransactionListPendingPage extends StatefulWidget {
  @override
  _TransactionListPendingPageState createState() => _TransactionListPendingPageState();
}

class _TransactionListPendingPageState extends State<TransactionListPendingPage> {
  TransactionStore _transactionStore;
  bool loaded = false;
  @override
  void initState() {
    _transactionStore = TransactionStore(TransactionRepository(CustomDio()));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!loaded) {
      final idUser = ModalRoute.of(context).settings.arguments as int;
      _transactionStore.listPending(idUser);
      loaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darker,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darker,
        title: Text('Transações Pendentes',
            style: TextStyle(color: primaryText, fontSize: 18)),
      ),
      body: Observer(
        builder: (_) {
          FutureStatus status = _transactionStore.listRequest.status;
          if (status == FutureStatus.fulfilled) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: _transactionStore.listRequest.value.length,
                itemBuilder: (context, index) {
                 return TransactionTile(
                   onTap: ()=> Navigator.pushNamed(context, '/account/details',arguments:_transactionStore.listRequest.value[index].idBankAccount),
                    transactionDto: _transactionStore.listRequest.value[index]);
              }),
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
    
        },
      ),
    );
  }
}

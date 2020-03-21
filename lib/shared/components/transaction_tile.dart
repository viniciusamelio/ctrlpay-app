import 'package:ctrl_money/shared/models/transaction_dto.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final TransactionDto transactionDto;
  FlutterMoneyFormatter _amountFormatter;
  TransactionTile({Key key, this.transactionDto}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _amountFormatter = FlutterMoneyFormatter(
        amount: transactionDto.amount,
        settings: MoneyFormatterSettings(
            decimalSeparator: ',', thousandSeparator: '.'));
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: transactionDto.idTransactionType == 2
                  ? Colors.lightGreen
                  : Colors.redAccent,
              borderRadius: BorderRadius.circular(4)),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                transactionDto.status.toUpperCase() == 'OK'
                    ? Icon(Icons.check, size: 35)
                    : Icon(Icons.close, size: 35),
                Text(transactionDto.status,
                    style: TextStyle(
                        color: darker,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            title: Text(
              '${transactionDto.category}',
              style: TextStyle(color: darker, fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
                transactionDto.idTransactionType == 1 ? 'Despesa' : 'Receita',
                style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: Text(_amountFormatter.output.nonSymbol),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Criada em: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transactionDto.createdAt))}',
            style: TextStyle(color: primaryText, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

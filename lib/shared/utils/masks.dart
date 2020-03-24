import 'package:flutter_money_formatter/flutter_money_formatter.dart';

String dateMask(String date){
  final splitedDate = date.split('-');
  return "${splitedDate[2]}/${splitedDate[1]}/${splitedDate[0]}";
}

String moneyMask(double amount){
  FlutterMoneyFormatter _moneyMask = FlutterMoneyFormatter(
    amount: amount,
    settings: MoneyFormatterSettings(
      decimalSeparator: ',',
      thousandSeparator: '.'
    )
  );
  return _moneyMask.output.nonSymbol;
}
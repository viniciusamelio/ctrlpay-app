import 'package:ctrl_money/report/models/amount_report_dto.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportPageResult extends StatefulWidget {
  final List<AmountReportDto> result;
  const ReportPageResult({Key key, this.result}) : super(key: key);
  @override
  _ReportPageResultState createState() => _ReportPageResultState();
}

class _ReportPageResultState extends State<ReportPageResult> {
  AmountReportDto _earnings;
  AmountReportDto _expenses;
  @override
  void initState() {
    bool hasEarnings, hasExpenses;
    hasEarnings =
        widget.result.where((e) => e.idTransactionType == 2).isNotEmpty;
    hasExpenses =
        widget.result.where((e) => e.idTransactionType == 1).isNotEmpty;
    if (hasEarnings) {
      _earnings = widget.result.where((e) => e.idTransactionType == 2).single;
    }
    if (hasExpenses) {
      _expenses = widget.result.where((e) => e.idTransactionType == 1).single;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darker,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darker,
        title: Text('Resultado',
            style: TextStyle(color: primaryText, fontSize: 18)),
      ),
      body: widget.result.length > 0
          ? GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: <Widget>[
                _earnings!= null ? Container(
                  margin: EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  height: 140,
                  width: 130,
                  decoration: BoxDecoration(
                      color: lighter, borderRadius: BorderRadius.circular(2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Receitas',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      Icon(
                        FontAwesomeIcons.arrowUp,
                        color: Colors.green,
                        size: 35,
                      ),
                      Text('${_earnings.amount ?? '0,00'}',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                ) : Container(),
                _expenses!= null ?Container(
                  margin: EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  height: 140,
                  width: 130,
                  decoration: BoxDecoration(
                      color: lighter, borderRadius: BorderRadius.circular(2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Despesas',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      Icon(
                        FontAwesomeIcons.arrowDown,
                        color: Colors.redAccent,
                        size: 35,
                      ),
                      Text('${_expenses.amount ?? '0,00'}',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                ) : Container(),
              ],
            )
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Icon(FontAwesomeIcons.solidFolderOpen, color: blue, size: 80),
                  const SizedBox(height: 10),
                  const Text('Você não efetuou transações no período especificado.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: secondaryText,
                          fontWeight: FontWeight.w700,
                          fontSize: 17)),
                  const SizedBox(height: 10),
                ],
              )),
          ),
    );
  }
}

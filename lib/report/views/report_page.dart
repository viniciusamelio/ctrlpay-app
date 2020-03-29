import 'package:ctrl_money/report/repositories/report_repository.dart';
import 'package:ctrl_money/report/stores/report_store.dart';
import 'package:ctrl_money/report/views/report_result_page.dart';
import 'package:ctrl_money/shared/components/date_widget.dart';
import 'package:ctrl_money/shared/models/user.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  ReportStore _reportStore;
  GlobalKey<FormState> _formKey;
  User _user;
  @override
  void initState() {
    _user = User.instance;
    _reportStore = ReportStore(ReportRepository(CustomDio()));
    _formKey = GlobalKey<FormState>();
    super.initState();
    reaction((_) => _reportStore.amountReportRequest.status, (_) {
      FutureStatus status = _reportStore.amountReportRequest.status;
      print(status);
      if (status == FutureStatus.fulfilled) {
        final value = _reportStore.amountReportRequest.value;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportPageResult(result: value)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Observer(builder: (_) {
        return _reportStore.amountReportRequest.status != FutureStatus.pending ?  FlatButton.icon(
          color: green,
          icon: Icon(Icons.cloud_upload, color: darker),
          label: Text(
            'Enviar',
            style: TextStyle(color: darker, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            if (_reportStore.amountReportRequest.status !=
                FutureStatus.pending) {
              if (_formKey.currentState.validate()) {
                _reportStore.amountReportRequestDto.idUser = _user.data.id;
                _reportStore.getAmountRequest();
              }
            }
          },
        ) : CircularProgressIndicator();
      }),
      backgroundColor: darker,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darker,
        title: Text('Relatório',
            style: TextStyle(color: primaryText, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DateTextFormField(
                onValidate: (date) {
                  _reportStore.amountReportRequestDto.begin = date;
                },
                validator: ((date) {
                  if (date.compareTo(DateTime.parse('2000-01-01')) < 0) {
                    return false;
                  }
                  return true;
                }),
                labelFail: "Data inválida",
                decoration: InputDecoration(
                    labelText: "Data de início",
                    suffixIcon: null,
                    prefixIcon: Icon(FontAwesomeIcons
                        .solidCalendar)), // Decoration to the widget
                showDatePicker: false,

                dateFormat: 'dd/mm/yyyy',
              ),
              const SizedBox(height: 10),
              DateTextFormField(
                onValidate: (date) {
                  _reportStore.amountReportRequestDto.end = date;
                },
                validator: ((date) {
                  if (date.compareTo(DateTime.parse('2000-01-01')) < 0) {
                    return false;
                  }
                  return true;
                }),
                labelFail: "Data inválida",
                decoration: InputDecoration(
                    labelText: "Data de fim",
                    suffixIcon: null,
                    prefixIcon: Icon(FontAwesomeIcons
                        .solidCalendar)), // Decoration to the widget
                showDatePicker: false,

                dateFormat: 'dd/mm/yyyy',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

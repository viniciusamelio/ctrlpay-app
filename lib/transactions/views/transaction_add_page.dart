import 'package:ctrl_money/shared/components/select.dart';
import 'package:ctrl_money/shared/models/transaction_dto.dart';
import 'package:ctrl_money/shared/repositories/transaction_repository.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:ctrl_money/transactions/stores/transaction_store.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class TransactionAddPage extends StatefulWidget {
  @override
  _TransactionAddPageState createState() => _TransactionAddPageState();
}

class _TransactionAddPageState extends State<TransactionAddPage> {
  GlobalKey<FormState> _transactionKey;
  MoneyMaskedTextController _amountController;
  TransactionStore _transactionStore;
  int _type = 1;
  int idBankAccount;

  @override
  void initState() {
    _amountController = MoneyMaskedTextController();
    _transactionKey = GlobalKey<FormState>();
    _transactionStore = TransactionStore(TransactionRepository(CustomDio()));
    reaction((_) => _transactionStore.addRequest.status, (_) {
      FutureStatus status = _transactionStore.addRequest.status;
      print(status);
      if (status == FutureStatus.fulfilled) {
        _transactionStore.dto = TransactionDto();
        _transactionStore.selectedStatus = null;
        _transactionStore.selectedCategory = null;
        Flushbar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          title: "Sucesso!",
          message: "Transação adicionada",
          mainButton: FlatButton(
            onPressed: () => Navigator.popUntil(
                context, (route) => route.settings.name == '/account'),
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
    idBankAccount = ModalRoute.of(context).settings.arguments as int;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darker,
      floatingActionButton: Observer(builder: (_) {
        if (_transactionStore.addRequest.status != FutureStatus.pending) {
          return FlatButton.icon(
              color: green,
              icon: Icon(Icons.save, color: darker),
              label: Text(
                'Enviar',
                style: TextStyle(color: darker, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_transactionKey.currentState.validate()) {
                  if (_transactionStore.selectedCategory != null) {
                    if (_transactionStore.selectedStatus != null) {
                      _transactionKey.currentState.save();
                      _transactionStore.dto.category =
                          _transactionStore.selectedCategory;
                      _transactionStore.dto.status =
                          _transactionStore.selectedStatus;
                      _transactionStore.dto.idTransactionType =
                          _transactionStore.transactionType;
                      _transactionStore.dto.idBankAccount = idBankAccount;
                      _transactionStore.add();
                    } else {
                      Flushbar(
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.redAccent,
                        title: "Opa",
                        message: "Selecione o status",
                      )..show(context);
                    }
                  } else {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.redAccent,
                      title: "Opa",
                      message: "Selecione uma categoria",
                    )..show(context);
                  }
                }
              });
        }
        return CircularProgressIndicator();
      }),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darker,
        title: Text('Nova transação',
            style: TextStyle(color: primaryText, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Form(
              key: _transactionKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: secondaryText),
                    onSaved: (e) => _transactionStore.dto.amount = double.parse(
                        e.replaceAll('.', '').replaceAll(',', '.')),
                    controller: _amountController,
                    validator: (e) {
                      if (e.isEmpty ||
                          double.tryParse(e.replaceAll('.', '').replaceAll(',', '.')) == null ||
                          double.parse(e.replaceAll('.', '').replaceAll(',', '.')) <= 0) {
                        return "Digite um valor válido";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Valor",
                        suffixIcon: IconButton(
                          onPressed: () => _amountController.text = "0,00",
                          icon: Icon(Icons.close),
                          color: secondaryText,
                        )),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: lighter,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black54)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Radio(
                                  activeColor: blue,
                                  groupValue: _type,
                                  onChanged: (e) {
                                    _transactionStore.transactionType = e;
                                    print(_transactionStore.transactionType);
                                    setState(() {
                                      _type = e;
                                    });
                                  },
                                  value: 1),
                              Text("Despesa",
                                  style: TextStyle(color: secondaryText)),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Radio(
                                activeColor: blue,
                                groupValue: _type,
                                onChanged: (e) {
                                  _transactionStore.transactionType = e;
                                  setState(() {
                                    _type = e;
                                  });
                                },
                                value: 2,
                              ),
                              Text(
                                "Receita",
                                style: TextStyle(color: secondaryText),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Observer(
                    builder: (_) {
                      return SelectInput(
                        selectedText:
                            _transactionStore.selectedStatus ?? "Status",
                        onChanged: (e) => _transactionStore.selectedStatus = e,
                        items: _transactionStore.transactionStatus
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Container(
                                    child: Text(e),
                                  ),
                                ))
                            .toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Observer(
                    builder: (_) {
                      return SelectInput(
                        selectedText:
                            _transactionStore.selectedCategory ?? "Categoria",
                        onChanged: (e) =>
                            _transactionStore.selectedCategory = e,
                        items: _transactionStore.transactionCategories
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Container(
                                    child: Text(e),
                                  ),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

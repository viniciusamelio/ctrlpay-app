// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReportStore on _ReportStore, Store {
  final _$amountReportRequestAtom =
      Atom(name: '_ReportStore.amountReportRequest');

  @override
  ObservableFuture<List<AmountReportDto>> get amountReportRequest {
    _$amountReportRequestAtom.context
        .enforceReadPolicy(_$amountReportRequestAtom);
    _$amountReportRequestAtom.reportObserved();
    return super.amountReportRequest;
  }

  @override
  set amountReportRequest(ObservableFuture<List<AmountReportDto>> value) {
    _$amountReportRequestAtom.context.conditionallyRunInAction(() {
      super.amountReportRequest = value;
      _$amountReportRequestAtom.reportChanged();
    }, _$amountReportRequestAtom,
        name: '${_$amountReportRequestAtom.name}_set');
  }

  final _$amountReportExpenseAtom =
      Atom(name: '_ReportStore.amountReportExpense');

  @override
  String get amountReportExpense {
    _$amountReportExpenseAtom.context
        .enforceReadPolicy(_$amountReportExpenseAtom);
    _$amountReportExpenseAtom.reportObserved();
    return super.amountReportExpense;
  }

  @override
  set amountReportExpense(String value) {
    _$amountReportExpenseAtom.context.conditionallyRunInAction(() {
      super.amountReportExpense = value;
      _$amountReportExpenseAtom.reportChanged();
    }, _$amountReportExpenseAtom,
        name: '${_$amountReportExpenseAtom.name}_set');
  }

  final _$amountReportEarningAtom =
      Atom(name: '_ReportStore.amountReportEarning');

  @override
  String get amountReportEarning {
    _$amountReportEarningAtom.context
        .enforceReadPolicy(_$amountReportEarningAtom);
    _$amountReportEarningAtom.reportObserved();
    return super.amountReportEarning;
  }

  @override
  set amountReportEarning(String value) {
    _$amountReportEarningAtom.context.conditionallyRunInAction(() {
      super.amountReportEarning = value;
      _$amountReportEarningAtom.reportChanged();
    }, _$amountReportEarningAtom,
        name: '${_$amountReportEarningAtom.name}_set');
  }

  final _$getAmountRequestAsyncAction = AsyncAction('getAmountRequest');

  @override
  Future<void> getAmountRequest() {
    return _$getAmountRequestAsyncAction.run(() => super.getAmountRequest());
  }

  @override
  String toString() {
    final string =
        'amountReportRequest: ${amountReportRequest.toString()},amountReportExpense: ${amountReportExpense.toString()},amountReportEarning: ${amountReportEarning.toString()}';
    return '{$string}';
  }
}

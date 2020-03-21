// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$slideIndexAtom = Atom(name: '_HomeStore.slideIndex');

  @override
  int get slideIndex {
    _$slideIndexAtom.context.enforceReadPolicy(_$slideIndexAtom);
    _$slideIndexAtom.reportObserved();
    return super.slideIndex;
  }

  @override
  set slideIndex(int value) {
    _$slideIndexAtom.context.conditionallyRunInAction(() {
      super.slideIndex = value;
      _$slideIndexAtom.reportChanged();
    }, _$slideIndexAtom, name: '${_$slideIndexAtom.name}_set');
  }

  final _$pendingRequestAtom = Atom(name: '_HomeStore.pendingRequest');

  @override
  ObservableFuture<List<PendingTransactionDto>> get pendingRequest {
    _$pendingRequestAtom.context.enforceReadPolicy(_$pendingRequestAtom);
    _$pendingRequestAtom.reportObserved();
    return super.pendingRequest;
  }

  @override
  set pendingRequest(ObservableFuture<List<PendingTransactionDto>> value) {
    _$pendingRequestAtom.context.conditionallyRunInAction(() {
      super.pendingRequest = value;
      _$pendingRequestAtom.reportChanged();
    }, _$pendingRequestAtom, name: '${_$pendingRequestAtom.name}_set');
  }

  final _$pendingEarningsAtom = Atom(name: '_HomeStore.pendingEarnings');

  @override
  double get pendingEarnings {
    _$pendingEarningsAtom.context.enforceReadPolicy(_$pendingEarningsAtom);
    _$pendingEarningsAtom.reportObserved();
    return super.pendingEarnings;
  }

  @override
  set pendingEarnings(double value) {
    _$pendingEarningsAtom.context.conditionallyRunInAction(() {
      super.pendingEarnings = value;
      _$pendingEarningsAtom.reportChanged();
    }, _$pendingEarningsAtom, name: '${_$pendingEarningsAtom.name}_set');
  }

  final _$pendingExpensesAtom = Atom(name: '_HomeStore.pendingExpenses');

  @override
  double get pendingExpenses {
    _$pendingExpensesAtom.context.enforceReadPolicy(_$pendingExpensesAtom);
    _$pendingExpensesAtom.reportObserved();
    return super.pendingExpenses;
  }

  @override
  set pendingExpenses(double value) {
    _$pendingExpensesAtom.context.conditionallyRunInAction(() {
      super.pendingExpenses = value;
      _$pendingExpensesAtom.reportChanged();
    }, _$pendingExpensesAtom, name: '${_$pendingExpensesAtom.name}_set');
  }

  final _$getPendingAsyncAction = AsyncAction('getPending');

  @override
  Future<void> getPending(int idUser) {
    return _$getPendingAsyncAction.run(() => super.getPending(idUser));
  }
}

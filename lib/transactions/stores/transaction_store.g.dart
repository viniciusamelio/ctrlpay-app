// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionStore on _TransactionStore, Store {
  final _$selectedStatusAtom = Atom(name: '_TransactionStore.selectedStatus');

  @override
  String get selectedStatus {
    _$selectedStatusAtom.context.enforceReadPolicy(_$selectedStatusAtom);
    _$selectedStatusAtom.reportObserved();
    return super.selectedStatus;
  }

  @override
  set selectedStatus(String value) {
    _$selectedStatusAtom.context.conditionallyRunInAction(() {
      super.selectedStatus = value;
      _$selectedStatusAtom.reportChanged();
    }, _$selectedStatusAtom, name: '${_$selectedStatusAtom.name}_set');
  }

  final _$transactionTypeAtom = Atom(name: '_TransactionStore.transactionType');

  @override
  int get transactionType {
    _$transactionTypeAtom.context.enforceReadPolicy(_$transactionTypeAtom);
    _$transactionTypeAtom.reportObserved();
    return super.transactionType;
  }

  @override
  set transactionType(int value) {
    _$transactionTypeAtom.context.conditionallyRunInAction(() {
      super.transactionType = value;
      _$transactionTypeAtom.reportChanged();
    }, _$transactionTypeAtom, name: '${_$transactionTypeAtom.name}_set');
  }

  final _$selectedCategoryAtom =
      Atom(name: '_TransactionStore.selectedCategory');

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.context.enforceReadPolicy(_$selectedCategoryAtom);
    _$selectedCategoryAtom.reportObserved();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.context.conditionallyRunInAction(() {
      super.selectedCategory = value;
      _$selectedCategoryAtom.reportChanged();
    }, _$selectedCategoryAtom, name: '${_$selectedCategoryAtom.name}_set');
  }

  final _$addRequestAtom = Atom(name: '_TransactionStore.addRequest');

  @override
  ObservableFuture<TransactionDto> get addRequest {
    _$addRequestAtom.context.enforceReadPolicy(_$addRequestAtom);
    _$addRequestAtom.reportObserved();
    return super.addRequest;
  }

  @override
  set addRequest(ObservableFuture<TransactionDto> value) {
    _$addRequestAtom.context.conditionallyRunInAction(() {
      super.addRequest = value;
      _$addRequestAtom.reportChanged();
    }, _$addRequestAtom, name: '${_$addRequestAtom.name}_set');
  }

  final _$addAsyncAction = AsyncAction('add');

  @override
  Future<void> add() {
    return _$addAsyncAction.run(() => super.add());
  }
}

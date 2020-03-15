// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BankAccountStore on _BankAccountStore, Store {
  final _$categoryListRequestAtom =
      Atom(name: '_BankAccountStore.categoryListRequest');

  @override
  ObservableFuture<List<BankAccountCategoryDto>> get categoryListRequest {
    _$categoryListRequestAtom.context
        .enforceReadPolicy(_$categoryListRequestAtom);
    _$categoryListRequestAtom.reportObserved();
    return super.categoryListRequest;
  }

  @override
  set categoryListRequest(
      ObservableFuture<List<BankAccountCategoryDto>> value) {
    _$categoryListRequestAtom.context.conditionallyRunInAction(() {
      super.categoryListRequest = value;
      _$categoryListRequestAtom.reportChanged();
    }, _$categoryListRequestAtom,
        name: '${_$categoryListRequestAtom.name}_set');
  }

  final _$listRequestAtom = Atom(name: '_BankAccountStore.listRequest');

  @override
  ObservableFuture<List<BankAccountDto>> get listRequest {
    _$listRequestAtom.context.enforceReadPolicy(_$listRequestAtom);
    _$listRequestAtom.reportObserved();
    return super.listRequest;
  }

  @override
  set listRequest(ObservableFuture<List<BankAccountDto>> value) {
    _$listRequestAtom.context.conditionallyRunInAction(() {
      super.listRequest = value;
      _$listRequestAtom.reportChanged();
    }, _$listRequestAtom, name: '${_$listRequestAtom.name}_set');
  }

  final _$addRequestAtom = Atom(name: '_BankAccountStore.addRequest');

  @override
  ObservableFuture<BankAccountDto> get addRequest {
    _$addRequestAtom.context.enforceReadPolicy(_$addRequestAtom);
    _$addRequestAtom.reportObserved();
    return super.addRequest;
  }

  @override
  set addRequest(ObservableFuture<BankAccountDto> value) {
    _$addRequestAtom.context.conditionallyRunInAction(() {
      super.addRequest = value;
      _$addRequestAtom.reportChanged();
    }, _$addRequestAtom, name: '${_$addRequestAtom.name}_set');
  }

  final _$getRequestAtom = Atom(name: '_BankAccountStore.getRequest');

  @override
  ObservableFuture<BankAccountDto> get getRequest {
    _$getRequestAtom.context.enforceReadPolicy(_$getRequestAtom);
    _$getRequestAtom.reportObserved();
    return super.getRequest;
  }

  @override
  set getRequest(ObservableFuture<BankAccountDto> value) {
    _$getRequestAtom.context.conditionallyRunInAction(() {
      super.getRequest = value;
      _$getRequestAtom.reportChanged();
    }, _$getRequestAtom, name: '${_$getRequestAtom.name}_set');
  }

  final _$currentTransactionAmountRequestAtom =
      Atom(name: '_BankAccountStore.currentTransactionAmountRequest');

  @override
  ObservableFuture<List<CurrentTransactionDto>>
      get currentTransactionAmountRequest {
    _$currentTransactionAmountRequestAtom.context
        .enforceReadPolicy(_$currentTransactionAmountRequestAtom);
    _$currentTransactionAmountRequestAtom.reportObserved();
    return super.currentTransactionAmountRequest;
  }

  @override
  set currentTransactionAmountRequest(
      ObservableFuture<List<CurrentTransactionDto>> value) {
    _$currentTransactionAmountRequestAtom.context.conditionallyRunInAction(() {
      super.currentTransactionAmountRequest = value;
      _$currentTransactionAmountRequestAtom.reportChanged();
    }, _$currentTransactionAmountRequestAtom,
        name: '${_$currentTransactionAmountRequestAtom.name}_set');
  }

  final _$selectedBankAccountCategoryAtom =
      Atom(name: '_BankAccountStore.selectedBankAccountCategory');

  @override
  BankAccountCategoryDto get selectedBankAccountCategory {
    _$selectedBankAccountCategoryAtom.context
        .enforceReadPolicy(_$selectedBankAccountCategoryAtom);
    _$selectedBankAccountCategoryAtom.reportObserved();
    return super.selectedBankAccountCategory;
  }

  @override
  set selectedBankAccountCategory(BankAccountCategoryDto value) {
    _$selectedBankAccountCategoryAtom.context.conditionallyRunInAction(() {
      super.selectedBankAccountCategory = value;
      _$selectedBankAccountCategoryAtom.reportChanged();
    }, _$selectedBankAccountCategoryAtom,
        name: '${_$selectedBankAccountCategoryAtom.name}_set');
  }

  final _$earningAtom = Atom(name: '_BankAccountStore.earning');

  @override
  double get earning {
    _$earningAtom.context.enforceReadPolicy(_$earningAtom);
    _$earningAtom.reportObserved();
    return super.earning;
  }

  @override
  set earning(double value) {
    _$earningAtom.context.conditionallyRunInAction(() {
      super.earning = value;
      _$earningAtom.reportChanged();
    }, _$earningAtom, name: '${_$earningAtom.name}_set');
  }

  final _$expenseAtom = Atom(name: '_BankAccountStore.expense');

  @override
  double get expense {
    _$expenseAtom.context.enforceReadPolicy(_$expenseAtom);
    _$expenseAtom.reportObserved();
    return super.expense;
  }

  @override
  set expense(double value) {
    _$expenseAtom.context.conditionallyRunInAction(() {
      super.expense = value;
      _$expenseAtom.reportChanged();
    }, _$expenseAtom, name: '${_$expenseAtom.name}_set');
  }

  final _$listCategoriesAsyncAction = AsyncAction('listCategories');

  @override
  Future<void> listCategories() {
    return _$listCategoriesAsyncAction.run(() => super.listCategories());
  }

  final _$listAsyncAction = AsyncAction('list');

  @override
  Future<void> list(UserDto user) {
    return _$listAsyncAction.run(() => super.list(user));
  }

  final _$addAsyncAction = AsyncAction('add');

  @override
  Future<void> add() {
    return _$addAsyncAction.run(() => super.add());
  }

  final _$getAsyncAction = AsyncAction('get');

  @override
  Future<void> get(int id) {
    return _$getAsyncAction.run(() => super.get(id));
  }

  final _$getCurrentTransactionAmountAsyncAction =
      AsyncAction('getCurrentTransactionAmount');

  @override
  Future<void> getCurrentTransactionAmount(int idBankAccount) {
    return _$getCurrentTransactionAmountAsyncAction
        .run(() => super.getCurrentTransactionAmount(idBankAccount));
  }
}

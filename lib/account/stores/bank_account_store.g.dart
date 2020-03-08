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
}

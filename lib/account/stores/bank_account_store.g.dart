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
}

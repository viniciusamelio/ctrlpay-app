// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpStore on _SignUpStore, Store {
  final _$visiblePasswordAtom = Atom(name: '_SignUpStore.visiblePassword');

  @override
  bool get visiblePassword {
    _$visiblePasswordAtom.context.enforceReadPolicy(_$visiblePasswordAtom);
    _$visiblePasswordAtom.reportObserved();
    return super.visiblePassword;
  }

  @override
  set visiblePassword(bool value) {
    _$visiblePasswordAtom.context.conditionallyRunInAction(() {
      super.visiblePassword = value;
      _$visiblePasswordAtom.reportChanged();
    }, _$visiblePasswordAtom, name: '${_$visiblePasswordAtom.name}_set');
  }

  final _$requestAtom = Atom(name: '_SignUpStore.request');

  @override
  ObservableFuture<dynamic> get request {
    _$requestAtom.context.enforceReadPolicy(_$requestAtom);
    _$requestAtom.reportObserved();
    return super.request;
  }

  @override
  set request(ObservableFuture<dynamic> value) {
    _$requestAtom.context.conditionallyRunInAction(() {
      super.request = value;
      _$requestAtom.reportChanged();
    }, _$requestAtom, name: '${_$requestAtom.name}_set');
  }

  final _$addAsyncAction = AsyncAction('add');

  @override
  Future<void> add() {
    return _$addAsyncAction.run(() => super.add());
  }

  @override
  String toString() {
    final string =
        'visiblePassword: ${visiblePassword.toString()},request: ${request.toString()}';
    return '{$string}';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$getRequestAtom = Atom(name: '_UserStore.getRequest');

  @override
  ObservableFuture<UserDto> get getRequest {
    _$getRequestAtom.context.enforceReadPolicy(_$getRequestAtom);
    _$getRequestAtom.reportObserved();
    return super.getRequest;
  }

  @override
  set getRequest(ObservableFuture<UserDto> value) {
    _$getRequestAtom.context.conditionallyRunInAction(() {
      super.getRequest = value;
      _$getRequestAtom.reportChanged();
    }, _$getRequestAtom, name: '${_$getRequestAtom.name}_set');
  }

  final _$getAsyncAction = AsyncAction('get');

  @override
  Future<void> get(String id) {
    return _$getAsyncAction.run(() => super.get(id));
  }
}

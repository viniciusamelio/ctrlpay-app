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

  final _$currentUserRequestAtom = Atom(name: '_UserStore.currentUserRequest');

  @override
  ObservableFuture<dynamic> get currentUserRequest {
    _$currentUserRequestAtom.context
        .enforceReadPolicy(_$currentUserRequestAtom);
    _$currentUserRequestAtom.reportObserved();
    return super.currentUserRequest;
  }

  @override
  set currentUserRequest(ObservableFuture<dynamic> value) {
    _$currentUserRequestAtom.context.conditionallyRunInAction(() {
      super.currentUserRequest = value;
      _$currentUserRequestAtom.reportChanged();
    }, _$currentUserRequestAtom, name: '${_$currentUserRequestAtom.name}_set');
  }

  final _$logoutRequestAtom = Atom(name: '_UserStore.logoutRequest');

  @override
  ObservableFuture<dynamic> get logoutRequest {
    _$logoutRequestAtom.context.enforceReadPolicy(_$logoutRequestAtom);
    _$logoutRequestAtom.reportObserved();
    return super.logoutRequest;
  }

  @override
  set logoutRequest(ObservableFuture<dynamic> value) {
    _$logoutRequestAtom.context.conditionallyRunInAction(() {
      super.logoutRequest = value;
      _$logoutRequestAtom.reportChanged();
    }, _$logoutRequestAtom, name: '${_$logoutRequestAtom.name}_set');
  }

  final _$userAtom = Atom(name: '_UserStore.user');

  @override
  UserDto get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(UserDto value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$getAsyncAction = AsyncAction('get');

  @override
  Future<void> get(int id) {
    return _$getAsyncAction.run(() => super.get(id));
  }

  final _$currentUserAsyncAction = AsyncAction('currentUser');

  @override
  Future<void> currentUser() {
    return _$currentUserAsyncAction.run(() => super.currentUser());
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    final string =
        'getRequest: ${getRequest.toString()},currentUserRequest: ${currentUserRequest.toString()},logoutRequest: ${logoutRequest.toString()},user: ${user.toString()}';
    return '{$string}';
  }
}

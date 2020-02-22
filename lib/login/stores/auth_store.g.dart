// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  final _$loginDtoAtom = Atom(name: '_AuthStore.loginDto');

  @override
  LoginDto get loginDto {
    _$loginDtoAtom.context.enforceReadPolicy(_$loginDtoAtom);
    _$loginDtoAtom.reportObserved();
    return super.loginDto;
  }

  @override
  set loginDto(LoginDto value) {
    _$loginDtoAtom.context.conditionallyRunInAction(() {
      super.loginDto = value;
      _$loginDtoAtom.reportChanged();
    }, _$loginDtoAtom, name: '${_$loginDtoAtom.name}_set');
  }

  final _$responseAtom = Atom(name: '_AuthStore.response');

  @override
  ObservableFuture<UserDto> get response {
    _$responseAtom.context.enforceReadPolicy(_$responseAtom);
    _$responseAtom.reportObserved();
    return super.response;
  }

  @override
  set response(ObservableFuture<UserDto> value) {
    _$responseAtom.context.conditionallyRunInAction(() {
      super.response = value;
      _$responseAtom.reportChanged();
    }, _$responseAtom, name: '${_$responseAtom.name}_set');
  }

  final _$keepConnectedResponseAtom =
      Atom(name: '_AuthStore.keepConnectedResponse');

  @override
  ObservableFuture<String> get keepConnectedResponse {
    _$keepConnectedResponseAtom.context
        .enforceReadPolicy(_$keepConnectedResponseAtom);
    _$keepConnectedResponseAtom.reportObserved();
    return super.keepConnectedResponse;
  }

  @override
  set keepConnectedResponse(ObservableFuture<String> value) {
    _$keepConnectedResponseAtom.context.conditionallyRunInAction(() {
      super.keepConnectedResponse = value;
      _$keepConnectedResponseAtom.reportChanged();
    }, _$keepConnectedResponseAtom,
        name: '${_$keepConnectedResponseAtom.name}_set');
  }

  final _$visiblePasswordAtom = Atom(name: '_AuthStore.visiblePassword');

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

  final _$keepConnectedAtom = Atom(name: '_AuthStore.keepConnected');

  @override
  bool get keepConnected {
    _$keepConnectedAtom.context.enforceReadPolicy(_$keepConnectedAtom);
    _$keepConnectedAtom.reportObserved();
    return super.keepConnected;
  }

  @override
  set keepConnected(bool value) {
    _$keepConnectedAtom.context.conditionallyRunInAction(() {
      super.keepConnected = value;
      _$keepConnectedAtom.reportChanged();
    }, _$keepConnectedAtom, name: '${_$keepConnectedAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<dynamic> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$stayConnectedAsyncAction = AsyncAction('stayConnected');

  @override
  Future<void> stayConnected() {
    return _$stayConnectedAsyncAction.run(() => super.stayConnected());
  }

  final _$checkStayConnectedAsyncAction = AsyncAction('checkStayConnected');

  @override
  Future checkStayConnected() {
    return _$checkStayConnectedAsyncAction
        .run(() => super.checkStayConnected());
  }

  final _$saveUserAsyncAction = AsyncAction('saveUser');

  @override
  Future saveUser(UserDto user) {
    return _$saveUserAsyncAction.run(() => super.saveUser(user));
  }
}

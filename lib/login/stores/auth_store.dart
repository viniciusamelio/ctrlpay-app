import 'dart:convert';

import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:ctrl_money/shared/services/istorage_service.dart';
import 'package:mobx/mobx.dart';
import 'package:ctrl_money/login/models/login_dto.dart';
import 'package:ctrl_money/login/repositories/iauth_repository.dart';

part 'auth_store.g.dart';

class AuthStore extends _AuthStore with _$AuthStore {
  AuthStore(IAuthRepository authRepository, IStorageService userStorage)
      : super(authRepository, userStorage);
}

abstract class _AuthStore with Store {
  @observable
  LoginDto loginDto;

  final IAuthRepository _authRepository;

  final IStorageService _userStorage;
  _AuthStore(this._authRepository, this._userStorage) {
    this.loginDto = LoginDto();
    checkStayConnected();
  }

  @observable
  ObservableFuture<UserDto> response = ObservableFuture.value(null);

  @observable
  ObservableFuture<String> keepConnectedResponse = ObservableFuture.value(null);

  @observable
  bool visiblePassword = false;

  @observable
  bool keepConnected;

  @action
  Future login() async {
    if (keepConnected) {
      await stayConnected();
    } else {
      await _userStorage.clear(key: "keep_connected");
    }
    response = _authRepository.login(loginDto).asObservable();
  }

  @action
  Future<void> stayConnected() async {
    await _userStorage.save(
        key: "keep_connected", value: keepConnected.toString());
  }

  @action
  checkStayConnected() async {
    keepConnected =
        await _userStorage.read(key: "keep_connected") == "true";
  }

  @action
  saveUser(UserDto user) async {
    await _userStorage.save(key: "user", value: jsonEncode(user.toJson()));
  }
}

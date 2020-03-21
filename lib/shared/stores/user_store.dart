import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:ctrl_money/shared/repositories/user_repository.dart';
import 'package:ctrl_money/shared/services/istorage_service.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore extends _UserStore with _$UserStore {
  UserStore(IUserRepository userRepository, IStorageService userStorage)
      : super(userRepository, userStorage);
}

abstract class _UserStore with Store {
  final IUserRepository _userRepository;
  final IStorageService _userStorage;
  _UserStore(this._userRepository, this._userStorage){
    currentUser();
  }

  @observable
  ObservableFuture<UserDto> getRequest = ObservableFuture.value(null);

  @observable
  ObservableFuture currentUserRequest = ObservableFuture.value(null);

  @observable
  ObservableFuture logoutRequest = ObservableFuture.value(null);
  
  @observable
  UserDto user;

  @action
  Future<void> get(int id) async {
    getRequest = _userRepository.get(id).asObservable();
  }

  @action
  Future<void> currentUser() async {
    currentUserRequest = _userStorage.read(key: 'user').asObservable();
  }

  @action 
  Future<void> logout() async{
    await _userStorage.clear(key: "keep_connected");
    logoutRequest = _userStorage.clear(key: 'user').asObservable();
  }
}

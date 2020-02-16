import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:ctrl_money/shared/repositories/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore extends _UserStore with _$UserStore{
  UserStore(IUserRepository userRepository) : super(userRepository);

}

abstract class _UserStore with Store{
  final IUserRepository _userRepository;
  _UserStore(this._userRepository);

  @observable 
  ObservableFuture<UserDto> getRequest = ObservableFuture.value(null);

  @action 
  Future<void> get(String id) async{
    getRequest = _userRepository.get(id).asObservable();
  }

}
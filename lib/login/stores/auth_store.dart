import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:mobx/mobx.dart';
import 'package:ctrl_money/login/models/login_dto.dart';
import 'package:ctrl_money/login/repositories/iauth_repository.dart';


part 'auth_store.g.dart';

class AuthStore extends _AuthStore with _$AuthStore{
  AuthStore(
    {IAuthRepository authRepository}
  ) : super(authRepository);
}

abstract class _AuthStore with Store{
  @observable
  LoginDto loginDto;

  final IAuthRepository _authRepository;
  
  _AuthStore(this._authRepository){
    this.loginDto = LoginDto();
  }

  @observable 
  ObservableFuture<UserDto> response = ObservableFuture.value(null);

  @observable 
  bool visiblePassword = false;

  @observable
  bool keepConnected;

  @action 
  Future login() {
    response = _authRepository.login(loginDto).asObservable();
  }

  @action 
  void stayConnected(){
    keepConnected = ! keepConnected;
  }

  @action 
  saveUser(bool e){
    if(e){
      //Montar lógica para salvar usuário
    }
  }


}
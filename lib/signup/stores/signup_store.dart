import 'package:ctrl_money/signup/models/signup_dto.dart';
import 'package:ctrl_money/signup/repositories/signup_repository.dart';
import 'package:mobx/mobx.dart';

part 'signup_store.g.dart';

class SignUpStore extends _SignUpStore with _$SignUpStore {
  SignUpStore(SignUpRepository repository) : super(repository);
}

abstract class _SignUpStore with Store {
  final SignUpRepository _repository;
  SignUpDto dto;

  _SignUpStore(this._repository) {
    dto = SignUpDto();
  }

  @observable
  bool visiblePassword = false;

  @observable
  ObservableFuture request = ObservableFuture.value(null);

  @action 
  Future<void> add() async{
    request = _repository.add(dto).asObservable();
  }
  

}

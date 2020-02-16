import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore extends _HomeStore with _$HomeStore{

}

abstract class _HomeStore with Store{

  

  @observable 
  int slideIndex = 0;

  
}
import 'package:ctrl_money/home/models/pending_transactions_dto.dart';
import 'package:ctrl_money/home/repositories/home_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore extends _HomeStore with _$HomeStore{
  HomeStore(IHomeRepository homeRepository) : super(homeRepository);
}

abstract class _HomeStore with Store{

  final IHomeRepository _homeRepository;

  _HomeStore(this._homeRepository);

  @observable 
  int slideIndex = 0;

  @observable
  ObservableFuture<List<PendingTransactionDto>> pendingRequest = ObservableFuture.value(null);

  @action
  Future<void> getPending(int idUser) async {
    pendingRequest = _homeRepository.listPending(idUser).asObservable();
  }
  @observable
  double pendingEarnings = 0;
  @observable
  double pendingExpenses = 0;

  
}
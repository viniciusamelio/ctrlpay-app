import 'package:ctrl_money/shared/models/transaction_dto.dart';
import 'package:ctrl_money/shared/repositories/transaction_repository.dart';
import 'package:mobx/mobx.dart';

part 'transaction_store.g.dart';

class TransactionStore extends _TransactionStore with _$TransactionStore {
  TransactionStore(TransactionRepository transactionRepository)
      : super(transactionRepository);
}

abstract class _TransactionStore with Store {
  final TransactionRepository _transactionRepository;
  _TransactionStore(this._transactionRepository);

  List<String> transactionStatus = ['Pendente', 'Ok'];
  List<String> transactionCategories = [
    'Alimentação',
    'Estudos',
    'Mobilidade',
    'Lazer',
    'Investimento',
    'Transferência',
    'Salário',
    'Freelance'
  ];
  Map<String, dynamic> category = {"1": "Despesa", "2": "Receita"};
  TransactionDto dto = TransactionDto();

  @observable
  String selectedStatus;
  @observable
  int transactionType = 1;
  @observable 
  String selectedCategory;

  @observable
  ObservableFuture<TransactionDto> addRequest = ObservableFuture.value(null);

  @observable
  ObservableFuture<TransactionDto> updateRequest = ObservableFuture.value(null);

  @action 
  Future<void> add() async{
    addRequest = _transactionRepository.add(dto).asObservable();
  }

  @action 
  Future<void> update() async{
    updateRequest = _transactionRepository.update(dto).asObservable();
  }
}

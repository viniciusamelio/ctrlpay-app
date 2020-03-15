import 'package:ctrl_money/account/models/bank_account_category_dto.dart';
import 'package:ctrl_money/account/models/bank_account_dto.dart';
import 'package:ctrl_money/account/repositories/bank_account_repository.dart';
import 'package:ctrl_money/shared/models/current_transaction_dto.dart';
import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:ctrl_money/shared/repositories/transaction_repository.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:mobx/mobx.dart';
part 'bank_account_store.g.dart';

class BankAccountStore extends _BankAccountStore with _$BankAccountStore{
  BankAccountStore(BankAccountRepository bankAccountRepository) : super(bankAccountRepository);
}

abstract class _BankAccountStore with Store{
  final BankAccountRepository bankAccountRepository;
  TransactionRepository transactionRepository;
  BankAccountDto bankAccountDto = BankAccountDto();
  _BankAccountStore(this.bankAccountRepository){
    transactionRepository = TransactionRepository(CustomDio());
  }

  @observable 
  ObservableFuture<List<BankAccountCategoryDto>> categoryListRequest = ObservableFuture.value(null);
  @observable
  ObservableFuture<List<BankAccountDto>> listRequest = ObservableFuture.value(null);
  @observable
  ObservableFuture<BankAccountDto> addRequest = ObservableFuture.value(null);
  @observable
  ObservableFuture<BankAccountDto> getRequest = ObservableFuture.value(null);
  @observable 
  ObservableFuture<List<CurrentTransactionDto>> currentTransactionAmountRequest = ObservableFuture.value(null);
  @observable
  BankAccountCategoryDto selectedBankAccountCategory;
  @observable
  double earning = 0.00;
  @observable 
  double expense = 0.00;

  @action 
  Future<void> listCategories() async{
    categoryListRequest = bankAccountRepository.getCategories().asObservable();
  }

  @action 
  Future<void> list(UserDto user) async{
    listRequest = bankAccountRepository.list(user).asObservable();
  }

  @action
  Future<void> add() async {
    addRequest = bankAccountRepository.add(bankAccountDto).asObservable();
  }

  @action
  Future<void> get(int id) async{
    getRequest = bankAccountRepository.get(id).asObservable();
  }

  @action 
  Future<void> getCurrentTransactionAmount(int idBankAccount) async{
    currentTransactionAmountRequest = transactionRepository.getCurrentTransactionsAmount(idBankAccount).asObservable();
  }
}
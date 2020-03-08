import 'package:ctrl_money/account/models/bank_account_category_dto.dart';
import 'package:ctrl_money/account/models/bank_account_dto.dart';
import 'package:ctrl_money/account/repositories/bank_account_repository.dart';
import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:mobx/mobx.dart';
part 'bank_account_store.g.dart';

class BankAccountStore extends _BankAccountStore with _$BankAccountStore{
  BankAccountStore(BankAccountRepository bankAccountRepository) : super(bankAccountRepository);
}

abstract class _BankAccountStore with Store{
  final BankAccountRepository bankAccountRepository;
  BankAccountDto bankAccountDto = BankAccountDto();
  _BankAccountStore(this.bankAccountRepository);

  @observable 
  ObservableFuture<List<BankAccountCategoryDto>> categoryListRequest = ObservableFuture.value(null);

  @observable
  ObservableFuture<List<BankAccountDto>> listRequest = ObservableFuture.value(null);

  @observable
  ObservableFuture<BankAccountDto> addRequest = ObservableFuture.value(null);

  @observable
  BankAccountCategoryDto selectedBankAccountCategory;

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
}
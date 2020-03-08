import 'package:ctrl_money/account/models/bank_account_category_dto.dart';
import 'package:ctrl_money/account/models/bank_account_dto.dart';
import 'package:ctrl_money/shared/config.dart';
import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:dio/dio.dart';

class BankAccountRepository {
  final Dio _dio;

  BankAccountRepository(this._dio);

  Future<List<BankAccountCategoryDto>> getCategories() async {
    try {
      List<BankAccountCategoryDto> _return = [];
      final response = await _dio.get('$url/category/account');
      for (var account in response.data as List) {
        _return.add(BankAccountCategoryDto.fromJson(account));
      }
      return _return;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BankAccountDto>> list(UserDto user) async {
    try {
      List<BankAccountDto> _return = [];
      final response = await _dio.post('$url/account/list',data: {"id_user" : user.id});
      for (var account in response.data as List) {
        _return.add(BankAccountDto.fromJson(account));
      }
      return _return;
    } catch (e) {
      rethrow;
    }
  }
}

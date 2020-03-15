import 'package:ctrl_money/shared/config.dart';
import 'package:ctrl_money/shared/models/current_transaction_dto.dart';
import 'package:dio/dio.dart';

abstract class ITransactionRepository{

}

class TransactionRepository{
  final Dio _dio;

  TransactionRepository(this._dio);

  Future<List<CurrentTransactionDto>> getCurrentTransactionsAmount(int idBankAccount) async {
    List _response = [];
    try {
      final response = await _dio.get('$url/transaction/current/transaction/$idBankAccount');
      for (var item in response.data) {
          _response.add(CurrentTransactionDto.fromMap(item));
      }
      return _response;
    } catch (e) {
      rethrow;
    }
  }
}
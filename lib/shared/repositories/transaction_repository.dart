import 'package:ctrl_money/shared/config.dart';
import 'package:ctrl_money/shared/models/current_transaction_dto.dart';
import 'package:ctrl_money/shared/models/transaction_dto.dart';
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

  Future<List<TransactionDto>> list(int idBankAccount) async {
    List<TransactionDto> _response = [];
    try {
      final response = await _dio.get('$url/transaction/$idBankAccount');
      for (var item in response.data) {
          _response.add(TransactionDto.fromJson(response.data));
      }
      return _response;
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionDto>add(TransactionDto transaction) async {
    try {
      final response = await _dio.post('$url/transaction',data: transaction.toJson());
      return TransactionDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
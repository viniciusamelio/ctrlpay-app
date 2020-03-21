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
    List<CurrentTransactionDto> list = [];
    try {
      final response = await _dio.get('$url/transaction/current/transaction/$idBankAccount');
      final data =response.data as List;
      for (var item in data) {
        list.add(CurrentTransactionDto.fromMap(item));
      } 
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionDto>> list(int idBankAccount) async {
    List<TransactionDto> _response = [];
    try {
      final response = await _dio.get('$url/transaction/$idBankAccount/5');
      for (var item in response.data) {
          _response.add(TransactionDto.fromJson(item));
      }
      return _response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionDto>> listAll(int idUser) async {
    List<TransactionDto> _response = [];
    try {
      final response = await _dio.get('$url/transaction/$idUser');
      for (var item in response.data) {
          _response.add(TransactionDto.fromJson(item));
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

  Future<TransactionDto> update(TransactionDto transaction) async {
    try {
      final response = await _dio.put('$url/transaction/${transaction.id}', data : transaction.toJson());
      return TransactionDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
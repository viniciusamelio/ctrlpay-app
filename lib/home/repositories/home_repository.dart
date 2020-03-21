import 'package:ctrl_money/home/models/pending_transactions_dto.dart';
import 'package:ctrl_money/shared/config.dart';
import 'package:dio/dio.dart';

abstract class IHomeRepository{
  Future<List<PendingTransactionDto>> listPending(int idUser);
}

class HomeReposiory implements IHomeRepository{

  final Dio _dio;

  HomeReposiory(this._dio);

  Future<List<PendingTransactionDto>> listPending(int idUser) async {
    List<PendingTransactionDto> list = [];
    try {
      final response = await _dio.get('$url/user/$idUser/pending');
      for (var item in response.data) {
        list.add(PendingTransactionDto.fromJson(item));
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }

}
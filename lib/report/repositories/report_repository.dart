import 'package:ctrl_money/report/models/amount_report_dto.dart';
import 'package:ctrl_money/report/models/amount_report_request_dto.dart';
import 'package:ctrl_money/shared/config.dart';
import 'package:dio/dio.dart';

abstract class IReportRepository{
Future<List<AmountReportDto>> getAmount(AmountReportRequestDto dto);
}


class ReportRepository implements IReportRepository{

  final Dio _dio;

  ReportRepository(this._dio);

  Future<List<AmountReportDto>> getAmount(AmountReportRequestDto dto) async {
    List<AmountReportDto> _return = [];
    try {
      final response = await _dio.post("$url/report/amount",data: dto.toJson());
      for (var item in response.data) {
        _return.add(AmountReportDto.fromJson(item));
      }
      return _return;
    } catch (e) {
      rethrow;
    }
  }

}
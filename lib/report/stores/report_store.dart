import 'package:ctrl_money/report/models/amount_report_dto.dart';
import 'package:ctrl_money/report/models/amount_report_request_dto.dart';
import 'package:ctrl_money/report/repositories/report_repository.dart';
import 'package:mobx/mobx.dart';

part 'report_store.g.dart';

class ReportStore extends _ReportStore with _$ReportStore{
  ReportStore(ReportRepository reportRepository) : super(reportRepository);
}

abstract class _ReportStore with Store{
  final ReportRepository _reportRepository;
  _ReportStore(this._reportRepository);

  AmountReportRequestDto amountReportRequestDto = AmountReportRequestDto();

  @observable
  ObservableFuture<List<AmountReportDto>> amountReportRequest = ObservableFuture.value(null);
  
  @observable
  String amountReportExpense;

  @observable
  String amountReportEarning;

  @action
  Future<void> getAmountRequest() async{
    amountReportRequest = _reportRepository.getAmount(amountReportRequestDto).asObservable();
  }

}
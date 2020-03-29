class AmountReportDto{

  int idTransactionType;
  String amount;

  AmountReportDto.fromJson(Map<String,dynamic> json){
    idTransactionType = json['id_transaction_type'];
    amount = json['amount'];
  }
}
class PendingTransactionDto {
  double amount;
  int idTransactionType;

  PendingTransactionDto({this.amount, this.idTransactionType});

  PendingTransactionDto.fromJson(Map<String, dynamic> json) {
    amount = double.parse(json['amount'].toString().replaceAll(',', ''));
    idTransactionType = json['id_transaction_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['id_transaction_type'] = this.idTransactionType;
    return data;
  }
}
class TransactionDto {
  int id;
  int idTransactionType;
  String status;
  String category;
  int idBankAccount;
  int amount;
  String createdAt;
  Null updatedAt;

  TransactionDto(
      {this.id,
      this.idTransactionType,
      this.status,
      this.category,
      this.idBankAccount,
      this.amount,
      this.createdAt,
      this.updatedAt});

  TransactionDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idTransactionType = json['id_transaction_type'];
    status = json['status'];
    category = json['category'];
    idBankAccount = json['id_bank_account'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_transaction_type'] = this.idTransactionType;
    data['status'] = this.status;
    data['category'] = this.category;
    data['id_bank_account'] = this.idBankAccount;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

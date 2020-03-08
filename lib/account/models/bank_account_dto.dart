class BankAccountDto {
  int id;
  int idUser;
  int idBankAccountCategory;
  double totalAmount;
  String createdAt;
  String updatedAt;
  String description;
  String message;

  BankAccountDto(
      {this.id,
      this.idUser,
      this.idBankAccountCategory,
      this.totalAmount,
      this.createdAt,
      this.updatedAt,
      this.description});

  BankAccountDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    idBankAccountCategory = json['id_bank_account_category'];
    totalAmount = double.parse(json['total_amount'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['id_category'] = this.idBankAccountCategory;
    data['total_amount'] = this.totalAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['description'] = this.description;
    return data;
  }
}

class CurrentTransactionDto {
  String description;
  double totalAmount;

  CurrentTransactionDto({this.description, this.totalAmount});

  CurrentTransactionDto.fromMap(Map<String, dynamic> json) {
    description = json['description'];
    totalAmount = double.parse(json['total_amount'].toString());
  }
}

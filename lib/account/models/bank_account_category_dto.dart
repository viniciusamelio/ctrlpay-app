class BankAccountCategoryDto {
  int id;
  String description;

  BankAccountCategoryDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['description'] = description;
    return json;
  }
}

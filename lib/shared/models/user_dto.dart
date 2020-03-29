class UserDto {
  int id;
  String name;
  String email;
  String birthDate;
  String avatar;
  String message;
  double totalAmount = 0;

  UserDto({this.id, this.name, this.email, this.birthDate, this.avatar});

  UserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    birthDate = json['birth_date'];
    avatar = json['avatar'];
    message = json['message'];
    totalAmount = double.tryParse(json['total_amount'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['birth_date'] = this.birthDate;
    data['avatar'] = this.avatar;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
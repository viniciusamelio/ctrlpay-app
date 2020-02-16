class SignUpDto {
  String name;
  String email;
  String password;
  String birthdate;

  SignUpDto({this.name, this.email, this.password, this.birthdate});

  SignUpDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['birthdate'] = this.birthdate;
    return data;
  }
}
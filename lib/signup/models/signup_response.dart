class SignUpResponse {
  int id;
  int idUser;
  String birthDate;
  int superuser;
  String avatar;
  String createdAt;
  String updatedAt;
  String message;

  SignUpResponse(
      {this.id,
      this.idUser,
      this.birthDate,
      this.superuser,
      this.avatar,
      this.createdAt,
      this.updatedAt});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    birthDate = json['birth_date'];
    superuser = json['superuser'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['birth_date'] = this.birthDate;
    data['superuser'] = this.superuser;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class TokenDto{
  String token;

  TokenDto.fromJson(Map<String,dynamic> json){
    this.token = json['token'];
  }
}
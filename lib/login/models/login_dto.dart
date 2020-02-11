class LoginDto{
   String username;
   String password;

  LoginDto({this.username, this.password});
  

  Map<String,String> toJson(){
    return {"username" : this.username, "password" : this.password};
  }
}
validateEmail(String email) {
  email = email.trim();
  if (email.isEmpty) {
    return "Digite o e-mail";
  } else if (!email.contains('@') || !email.contains('.')) {
    return "Digite um e-mail válido";
  }
}

validatePassword(String password){
  if(password.isEmpty){
    return "Digite a senha";
  }else if(password.length < 3){
    return "Digite uma senha com ao menos 3 caracteres";
  }
}

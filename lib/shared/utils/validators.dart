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

validateBirthdate(String date){
  if(date.isEmpty){
    return "Digite sua data de nascimento";
  }else if(date.split('/').length != 3 || int.parse(date.substring(date.length-1,date.length)) > 2010){
    return "Digite uma data de nascimento válida";
  }
}

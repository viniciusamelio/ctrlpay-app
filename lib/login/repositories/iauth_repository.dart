import 'package:ctrl_money/login/models/login_dto.dart';
import 'package:ctrl_money/shared/models/token_dto.dart';


abstract class IAuthRepository{
  Future<TokenDto> login(LoginDto dto);
}
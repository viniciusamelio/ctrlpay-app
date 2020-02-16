import 'package:ctrl_money/login/models/login_dto.dart';
import 'package:ctrl_money/shared/models/user_dto.dart';


abstract class IAuthRepository{
  Future<UserDto> login(LoginDto dto);
}
import 'package:ctrl_money/login/models/login_dto.dart';
import 'package:ctrl_money/login/repositories/iauth_repository.dart';
import 'package:ctrl_money/shared/config.dart';
import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:dio/dio.dart';

class AuthRepository implements IAuthRepository {
  final CustomDio _dio;

  AuthRepository(this._dio);

  Future<UserDto> login(LoginDto user) async {
    try {
      final response = await _dio.post(
          "$url/auth",
          data: user.toJson());
      return UserDto.fromJson(response.data);
    } catch (e) {
      if (e is DioError && e != null) {
        throw e.response.data;
      }
      rethrow;
    }
  }
}

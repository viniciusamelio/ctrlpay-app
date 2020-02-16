import 'package:ctrl_money/shared/config.dart';
import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:dio/dio.dart';

abstract class IUserRepository{
  Future<UserDto> get(String id);
}

class UserRepository implements IUserRepository {
  final Dio _dio;

  UserRepository(this._dio);

  Future<UserDto> get(String id) async {
    try {
      final response = await _dio.get("$url/user/$id");
      return UserDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}

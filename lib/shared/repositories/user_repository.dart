import 'dart:convert';

import 'package:ctrl_money/shared/config.dart';
import 'package:ctrl_money/shared/models/user_dto.dart';
import 'package:dio/dio.dart';

abstract class IUserRepository {
  Future<UserDto> get(int id);
  Future<UserDto> upload(UserDto user);
}

class UserRepository implements IUserRepository {
  final Dio _dio;

  UserRepository(this._dio);

  Future<UserDto> get(int id) async {
    try {
      final response = await _dio.get("$url/user/$id");
      return UserDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserDto> upload(UserDto user) async {
    try {
      final response = await _dio.patch("$url/user", data: user.toJson());
      return UserDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}

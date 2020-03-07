import 'package:ctrl_money/shared/config.dart';
import 'package:ctrl_money/signup/models/signup_dto.dart';
import 'package:ctrl_money/signup/models/signup_response.dart';
import 'package:dio/dio.dart';

class SignUpRepository {
  final Dio _dio;

  SignUpRepository(this._dio);

  Future<SignUpResponse> add(SignUpDto dto) async {
    try {
      final response = await _dio.post("$url/user", data: dto.toJson());
      return SignUpResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}

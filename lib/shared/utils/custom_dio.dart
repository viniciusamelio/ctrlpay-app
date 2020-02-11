import 'package:ctrl_money/login/repositories/token_service.dart';
import 'package:ctrl_money/shared/config.dart';
import 'package:ctrl_money/shared/services/istorage_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

class CustomDio extends DioForNative {
  Dio _dio;
  IStorageService _tokenService;

  CustomDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: url
      )
    );
    _tokenService = TokenService();    
    _dio.interceptors.add(InterceptorsWrapper(onError: (DioError error) {
      throw (error);
    }, onRequest: (RequestOptions options) async {
      options.baseUrl = _dio.options.baseUrl;
      options.headers = {"x-app-key": "ctrlpay-app-dev"};
      List withoutToken = ["/auth", "/register"];

      if (!withoutToken.any((e) => e == options.path.replaceAll(_dio.options.baseUrl, ''))) {
        final token = await _tokenService.read(key: "token");
        options.headers['Authorization'] = token;
      }
    }, onResponse: (Response response) async {
      if (response.request.path == "${_dio.options.baseUrl}/path") {
        Map<String, dynamic> data = response.data;
        if (data.containsKey("token")) {
          await _tokenService.save(key: "token", value: data);
        }
      }
    }));
  }
}

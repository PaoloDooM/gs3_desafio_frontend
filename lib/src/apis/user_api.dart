import 'package:dio/dio.dart';
import 'package:gs3_desafio_front/src/configurations.dart';

class UserApi {
  static Future<String> login(String email, String password) async {
    try {
      Response response = await Dio().post(
          '${Configurations.baseUrl}/user/login',
          data: {"email": email, "password": password});
      return response.data['token'];
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw "Timeout reached";
        case DioExceptionType.badCertificate:
          throw e.type.name;
        case DioExceptionType.badResponse:
          throw e.response?.data['message'] ??
              "${e.type.name} ${e.response?.statusCode}".trim();
        case DioExceptionType.cancel:
          throw "Canceled operation";
        case DioExceptionType.connectionError:
          throw "Connection error";
        case DioExceptionType.unknown:
          throw "Unknown error";
      }
    } catch (e){
      throw "Unknown error";
    }
  }
}

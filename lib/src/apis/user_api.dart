import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/apis/http_api_client.dart';
import 'package:gs3_desafio_front/src/configurations.dart';
import 'package:gs3_desafio_front/src/models/user_model.dart';

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
    } catch (e) {
      throw "Unknown error";
    }
  }

  static Future<UserModel> getLoggedUser() async {
    try {
      Response response = await GetIt.I<HttpApiClient>().get('/user');
      return UserModel.fromJson(response.data);
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
    } catch (e) {
      throw "Unknown error";
    }
  }
}

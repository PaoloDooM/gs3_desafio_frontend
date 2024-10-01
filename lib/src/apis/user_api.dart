import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/apis/http_api_client.dart';
import 'package:gs3_desafio_front/src/configurations.dart';
import 'package:gs3_desafio_front/src/models/profile_model.dart';
import 'package:gs3_desafio_front/src/models/telephone_number_model.dart';
import 'package:gs3_desafio_front/src/models/user_model.dart';

import '../models/address_model.dart';

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

  static Future<void> updateAddress(AddressModel address) async {
    try {
      await GetIt.I<HttpApiClient>()
          .put('/user/address', data: address.toJson());
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

  static Future<void> deleteAddress(AddressModel address) async {
    try {
      await GetIt.I<HttpApiClient>().delete(
        '/user/address/${address.id}',
      );
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

  static Future<void> updatePhone(TelephoneNumberModel phone) async {
    try {
      await GetIt.I<HttpApiClient>()
          .put('/user/phonenumber', data: phone.toJson());
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

  static Future<void> deletePhone(TelephoneNumberModel phone) async {
    try {
      await GetIt.I<HttpApiClient>().delete(
        '/user/phonenumber/${phone.id}',
      );
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

  static Future<List<ProfileModel>> getProfiles() async {
    try {
      Response response = await GetIt.I<HttpApiClient>().get(
        '/profile/list',
      );
      return response.data.map((e) => ProfileModel.fromJson(e)).toList();
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

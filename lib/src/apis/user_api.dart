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

  static Future updateAddress(AddressModel address,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>().put('/user/address',
          data: address.toJson(), cancelToken: cancelToken);
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

  static Future<void> updatePhone(TelephoneNumberModel phone,
      {CancelToken? cancelToken}) async {
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

  static Future<void> deleteUser(UserModel user) async {
    try {
      await GetIt.I<HttpApiClient>().delete(
        '/user/${user.id}',
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
      return response.data
          .map<ProfileModel>((e) => ProfileModel.fromJson(e))
          .toList();
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

  static Future<List<UserModel>> getUsers() async {
    try {
      Response response = await GetIt.I<HttpApiClient>().get(
        '/user/list',
      );
      return response.data
          .map<UserModel>((e) => UserModel.fromJson(e))
          .toList();
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

  static Future updateUser(UserModel user, {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>()
          .put('/user', data: user.toJson(), cancelToken: cancelToken);
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

  static Future addAddress(AddressModel address,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>().post('/user/address',
          data: address.toJson(), cancelToken: cancelToken);
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

  static Future<void> addPhone(TelephoneNumberModel phone,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>()
          .post('/user/phonenumber', data: phone.toJson());
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

  static Future<void> addUser(UserModel user,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>().post('/user', data: user.toJsonDto());
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

  static Future<void> updateUserById(UserModel user,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>()
          .put('/user/${user.id}', data: user.toJsonDto());
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

  static Future<UserModel> getUserById(int userId,
      {CancelToken? cancelToken}) async {
    try {
      Response response = await GetIt.I<HttpApiClient>().get('/user/$userId');
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

  static Future deleteAddressById(int userId, AddressModel address,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>()
          .delete('/user/$userId/address/${address.id}');
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

  static Future updateAddressById(int userId, AddressModel address,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>()
          .put('/user/$userId/address', data: address.toJson());
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

  static Future addAddressById(int userId, AddressModel address,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>()
          .post('/user/$userId/address', data: address.toJson());
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

  static Future deletePhoneById(int userId, TelephoneNumberModel phone,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>()
          .delete('/user/$userId/phonenumber/${phone.id}');
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

  static Future updatePhoneById(int userId, TelephoneNumberModel phone,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>()
          .put('/user/$userId/phonenumber', data: phone.toJson());
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

  static Future addPhoneById(int userId, TelephoneNumberModel phone,
      {CancelToken? cancelToken}) async {
    try {
      await GetIt.I<HttpApiClient>()
          .post('/user/$userId/phonenumber', data: phone.toJson());
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

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../main.dart';
import '../../ui/pages/login_page.dart';
import '../../ui/stores/user_store.dart';
import 'http_api_client.dart';

class HttpInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? apiToken = GetIt.I<UserStore>().apiToken;
    if (apiToken == null) {
      throw DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: options, statusCode: 401));
    } else {
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
      super.onRequest(options, handler);
    }
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    GetIt.I<HttpApiClient>()
        .removeCancelToken(response.requestOptions.cancelToken);
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.badResponse &&
        err.response?.statusCode == 401 &&
        GetIt.I<UserStore>().apiToken != null) {
      GetIt.I<HttpApiClient>().cancelAllRequests();
      await GetIt.I<UserStore>().setApiToken(null);
      navigatorKey.currentState?.pushReplacement(MaterialPageRoute<void>(
        builder: (BuildContext context) => const LoginPage(),
      ));
      GetIt.I<UserStore>().setUser(null);
    } else {
      GetIt.I<HttpApiClient>()
          .removeCancelToken(err.requestOptions.cancelToken);
      super.onError(err, handler);
    }
  }
}

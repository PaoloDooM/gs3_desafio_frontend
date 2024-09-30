import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../ui/stores/user_store.dart';
import 'http_api_client.dart';

class HttpInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //TODO: ADD NULL TOKEN LOGIC
    options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${GetIt.I<UserStore>().apiToken!}";
    super.onRequest(options, handler);
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
    //TODO: LOGOUT WHEN TOKEN EXPIRES
    GetIt.I<HttpApiClient>().removeCancelToken(err.requestOptions.cancelToken);
    super.onError(err, handler);
  }
}

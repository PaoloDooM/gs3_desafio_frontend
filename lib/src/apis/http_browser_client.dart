import 'dart:io';
import 'package:dio/browser.dart';
import '../configurations.dart';
import 'http_interceptor.dart';

class HttpDioClient extends DioForBrowser {
  HttpDioClient([super.options]) {
    super.options
      ..baseUrl = Configurations.baseUrl
      ..headers = {
        HttpHeaders.userAgentHeader: 'gs3_desafio/web',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      };
    interceptors.add(
      HttpInterceptor(),
    );
  }
}

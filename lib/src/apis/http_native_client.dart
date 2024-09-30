import 'dart:io';
import 'package:dio/io.dart';
import '../configurations.dart';
import 'http_interceptor.dart';

class HttpDioClient extends DioForNative {
  HttpDioClient([super.options]) {
    super.options
      ..baseUrl = Configurations.baseUrl
      ..headers = {
        HttpHeaders.userAgentHeader: 'gs3_desafio/mobile',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      };
    interceptors.add(
      HttpInterceptor(),
    );
  }
}

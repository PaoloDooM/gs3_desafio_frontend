import 'package:dio/dio.dart';
import 'http_native_client.dart';

class HttpApiClient extends HttpDioClient {
  List<CancelToken> cancelTokens = [];

  CancelToken createCancelToken({CancelToken? cancelToken}) {
    cancelToken ??= CancelToken();
    cancelTokens.add(cancelToken);
    return cancelToken;
  }

  cancelAllRequests({CancelToken? exclude}) {
    for (CancelToken cancelToken in List.of(cancelTokens)) {
      if (exclude != cancelToken) {
        cancelToken.cancel();
        cancelTokens.remove(cancelToken);
      }
    }
  }

  removeCancelToken(CancelToken? cancelToken) {
    if (cancelToken != null) {
      cancelTokens.remove(cancelToken);
    }
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return super.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: createCancelToken(cancelToken: cancelToken),
    );
  }

  @override
  Future<Response<T>> getUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return super.getUri(
      uri,
      data: data,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: createCancelToken(cancelToken: cancelToken),
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return super.post(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: createCancelToken(cancelToken: cancelToken),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> postUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return super.postUri(
      uri,
      data: data,
      options: options,
      cancelToken: createCancelToken(cancelToken: cancelToken),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return super.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: createCancelToken(cancelToken: cancelToken),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> putUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return super.putUri(
      uri,
      data: data,
      options: options,
      cancelToken: createCancelToken(cancelToken: cancelToken),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> head<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return super.head(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: createCancelToken(cancelToken: cancelToken),
    );
  }

  @override
  Future<Response<T>> headUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return super.headUri(
      uri,
      data: data,
      options: options,
      cancelToken: createCancelToken(cancelToken: cancelToken),
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return super.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: createCancelToken(cancelToken: cancelToken),
    );
  }

  @override
  Future<Response<T>> deleteUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return super.deleteUri(
      uri,
      data: data,
      options: options,
      cancelToken: createCancelToken(cancelToken: cancelToken),
    );
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return super.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: createCancelToken(cancelToken: cancelToken),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> patchUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return super.patchUri(
      uri,
      data: data,
      options: options,
      cancelToken: createCancelToken(cancelToken: cancelToken),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response> downloadUri(
    Uri uri,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) {
    return super.downloadUri(
      uri,
      savePath,
      onReceiveProgress: onReceiveProgress,
      lengthHeader: lengthHeader,
      deleteOnError: deleteOnError,
      cancelToken: createCancelToken(cancelToken: cancelToken),
      data: data,
      options: options,
    );
  }

  @override
  Future<Response> download(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) {
    return super.download(urlPath, savePath,
        data: data,
        cancelToken: createCancelToken(cancelToken: cancelToken),
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        onReceiveProgress: onReceiveProgress,
        options: options,
        queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> requestUri<T>(
    Uri uri, {
    Object? data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return super.requestUri(
      uri,
      data: data,
      cancelToken: createCancelToken(cancelToken: cancelToken),
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> request<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return super.request(
      path,
      options: options,
      data: data,
      queryParameters: queryParameters,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      cancelToken: createCancelToken(cancelToken: cancelToken),
    );
  }
}

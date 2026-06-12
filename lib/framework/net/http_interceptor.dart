import 'package:dio/dio.dart';

/// 网络请求拦截器
class HttpInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 在请求之前可以做一些处理，比如添加 token
    // final token = await getToken();
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    // 处理响应数据
    if (response.statusCode == 200) {
      handler.next(response);
    } else {
      handler.reject(DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: '请求失败，状态码：${response.statusCode}',
      ));
    }
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    // 统一处理错误
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        err = DioException(
          requestOptions: err.requestOptions,
          error: '连接超时',
          type: err.type,
        );
        break;
      case DioExceptionType.sendTimeout:
        err = DioException(
          requestOptions: err.requestOptions,
          error: '发送超时',
          type: err.type,
        );
        break;
      case DioExceptionType.receiveTimeout:
        err = DioException(
          requestOptions: err.requestOptions,
          error: '接收超时',
          type: err.type,
        );
        break;
      case DioExceptionType.badResponse:
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: '服务器错误，状态码：${err.response?.statusCode}',
          type: err.type,
        );
        break;
      case DioExceptionType.cancel:
        err = DioException(
          requestOptions: err.requestOptions,
          error: '请求已取消',
          type: err.type,
        );
        break;
      case DioExceptionType.unknown:
        err = DioException(
          requestOptions: err.requestOptions,
          error: '未知错误',
          type: err.type,
        );
        break;
      default:
        break;
    }

    handler.next(err);
  }
}

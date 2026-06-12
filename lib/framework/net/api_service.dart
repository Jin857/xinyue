import 'package:dio/dio.dart';
import 'http_client.dart';
import 'http_response.dart';

/// API 服务基类
abstract class ApiService {
  final HttpClient _client = HttpClient();

  /// 发起请求并返回统一响应
  Future<MHttpResponse<T>> request<T>(
    String path, {
    String method = 'GET',
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await _client.get(path, queryParameters: queryParameters);
          break;
        case 'POST':
          response = await _client.post(
            path,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case 'PUT':
          response = await _client.put(
            path,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case 'DELETE':
          response = await _client.delete(
            path,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        default:
          throw Exception('不支持的请求方法: $method');
      }

      if (response.data is Map) {
        return MHttpResponse.fromJson(response.data);
      } else {
        return MHttpResponse.error(code: -1, message: '响应数据格式错误');
      }
    } on DioException catch (e) {
      return MHttpResponse.error(
        code: e.response?.statusCode ?? -1,
        message: e.error?.toString() ?? '网络请求失败',
      );
    } catch (e) {
      return MHttpResponse.error(code: -1, message: e.toString());
    }
  }

  /// 发起分页请求
  Future<HttpPageResponse<T>> requestPage<T>(
    String path, {
    String method = 'GET',
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    final response = await request<Map<String, dynamic>>(
      path,
      method: method,
      data: data,
      queryParameters: queryParameters,
    );

    if (response.success && response.data != null) {
      return HttpPageResponse.fromJson(response.data!, fromJson);
    } else {
      throw Exception(response.message);
    }
  }

  /// 获取 Dio 实例（用于特殊需求）
  Dio get dio => _client.dio;
}

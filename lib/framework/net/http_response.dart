/// 网络请求响应模型
class MHttpResponse<T> {
  /// 状态码
  final int code;

  /// 消息
  final String message;

  /// 数据
  final T? data;

  /// 是否成功
  bool get success => code == 200;

  const MHttpResponse({required this.code, required this.message, this.data});

  /// 从 JSON 解析
  factory MHttpResponse.fromJson(Map<String, dynamic> json) {
    return MHttpResponse(
      code: json['code'] as int,
      message: json['message'] as String? ?? '',
      data: json['data'] as T?,
    );
  }

  /// 成功响应
  factory MHttpResponse.success({T? data, String message = 'success'}) {
    return MHttpResponse(code: 200, message: message, data: data);
  }

  /// 失败响应
  factory MHttpResponse.error({required int code, required String message}) {
    return MHttpResponse(code: code, message: message, data: null);
  }
}

/// 分页响应模型
class HttpPageResponse<T> {
  /// 当前页码
  final int page;

  /// 每页数量
  final int pageSize;

  /// 总数量
  final int total;

  /// 总页数
  final int totalPages;

  /// 数据列表
  final List<T> list;

  const HttpPageResponse({
    required this.page,
    required this.pageSize,
    required this.total,
    required this.totalPages,
    required this.list,
  });

  /// 从 JSON 解析
  factory HttpPageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJson,
  ) {
    final List<dynamic> dataList = json['list'] as List;
    return HttpPageResponse(
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      total: json['total'] as int,
      totalPages: json['totalPages'] as int,
      list: dataList.map((e) => fromJson(e)).toList(),
    );
  }

  /// 是否有更多数据
  bool get hasMore => page < totalPages;
}

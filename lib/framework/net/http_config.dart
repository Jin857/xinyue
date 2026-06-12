/// 网络请求配置
class HttpConfig {
  /// 基础 URL
  static const String baseUrl = 'https://api.example.com';

  /// 连接超时时间（毫秒）
  static const int connectTimeout = 10000;

  /// 接收超时时间（毫秒）
  static const int receiveTimeout = 10000;

  /// 发送超时时间（毫秒）
  static const int sendTimeout = 10000;

  /// 默认请求头
  static Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      };
}

/// API 路径常量
class ApiPath {
  /// 商品列表
  static const String products = '/products';

  /// 商品详情
  static const String productDetail = '/products/{id}';

  /// 用户登录
  static const String login = '/auth/login';

  /// 用户注册
  static const String register = '/auth/register';

  /// 用户信息
  static const String userInfo = '/user/info';
}

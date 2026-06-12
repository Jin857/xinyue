/// 应用运行环境枚举
///
/// 用于区分不同的运行阶段，以便注入不同的配置（如 API 地址、日志级别等）。
enum AppEnv {
  /// 开发
  dev('dev'),

  /// 测试环境
  test('test'),

  /// 生产环境
  prod('prod');

  const AppEnv(this.value);

  final String value;

  /// 辅助判断是否为生产环境
  bool get isProd => this == AppEnv.prod;

  /// 从字符串解析环境，默认回退到 dev
  static AppEnv fromValue(String rawValue) {
    return AppEnv.values.firstWhere(
      (item) => item.value == rawValue,
      orElse: () => AppEnv.dev,
    );
  }
}

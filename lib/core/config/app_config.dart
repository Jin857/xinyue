import 'package:xinyue/model/app_config_model.dart';

/// App 配置
/// 包括 当前环境 - 全局单例
class AppConfig {
  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  static AppConfig get instance => _instance;

  /// App环境
  late final AppEnv appEnv;

  /// 初始化
  Future<void> init() async {
    const evn = String.fromEnvironment('APP_ENV', defaultValue: 'dev');
    appEnv = AppEnv.fromValue(evn);
  }
}

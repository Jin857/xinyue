import 'package:xinyue/core/config/app_config.dart';

class AppInitialization {
  /// App 初始化
  static Future<void> init() async {
    /// 初始化App配置
    await AppConfig.instance.init();
  }
}

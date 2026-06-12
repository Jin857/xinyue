import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xinyue/core/initialization/app_initialization.dart';
import 'package:xinyue/framework/my_material_app.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await AppInitialization.init();
      runApp(const ProviderScope(child: MyMaterialApp()));
    },
    (error, stackTrace) {
      // 这是启动最早期的兜底分支：此时 logger 还不存在，不能再依赖项目日志系统。
      debugPrint('Uncaught boot error: $error\n$stackTrace');
      return;
    },
  );
}

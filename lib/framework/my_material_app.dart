import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xinyue/constant/app_%20theme.dart';
import 'package:xinyue/core/config/app_config.dart';
import 'package:xinyue/framework/router/router.dart';
import 'package:xinyue/framework/adaptive/app_adaptive.dart';
import 'package:xinyue/l10n/app_localizations.dart';
import 'package:xinyue/model/app_config_model.dart';

class MyMaterialApp extends ConsumerWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return AppAdaptive(
      builder: (context) => MaterialApp.router(
        // 动态生成标题（支持国际化）
        onGenerateTitle: (context) => AppLocalizations.of(context).title,
        // 路由配置入口
        routerConfig: router,
        // 声明你的App支持的所有语言环境
        supportedLocales: const [Locale('en'), Locale('zh')],
        // 注册本地化代理，包含自动生成的委托
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // 是否是debug
        debugShowCheckedModeBanner: AppConfig.instance.appEnv != AppEnv.prod,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}

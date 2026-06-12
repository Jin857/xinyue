import 'package:flutter/widgets.dart';
import 'package:xinyue/constant/app_adaptive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 应用级屏幕适配初始化容器。
///
/// 第三方库初始化只放在这里，业务和主题层通过 AppAdaptive 获取换算结果。
class AppAdaptive extends StatelessWidget {
  const AppAdaptive({super.key, required this.builder});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: minTextAdapt,
      splitScreenMode: splitScreenMode,
      builder: (context, child) => builder(context),
    );
  }
}

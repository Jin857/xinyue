import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xinyue/constant/app_router.dart' as router;
import 'package:xinyue/provider/user/app_user_info.dart';
import 'package:go_router/go_router.dart';

FutureOr<String?> homeRedirect(
  BuildContext context,
  GoRouterState state,
  Ref ref, // 这里必须加 ref！
) async {
  await ref.read(userInfoProvider.future);
  // 已登录 → 跳首页
  return router.homePath;
}

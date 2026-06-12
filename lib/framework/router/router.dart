import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xinyue/constant/app_router.dart' as router;
import 'package:xinyue/framework/router/redirects/home_redirect.dart';

import 'package:xinyue/page/home/home_page.dart';
import 'package:xinyue/page/login_page.dart';
import 'package:go_router/go_router.dart';

/// 应用级 GoRouter 实例 Provider
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: router.homePath,
    routes: [
      GoRoute(
        path: router.homePath,
        builder: (context, state) => const HomePage(),
        redirect: (context, state) => homeRedirect(context, state, ref),
      ),
      GoRoute(
        path: router.loginPath,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
});

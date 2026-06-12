import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xinyue/model/user_info.dart';
import 'package:xinyue/provider/user/app_user_info.dart';
import 'package:xinyue/widget/no_login_widget.dart';
import 'package:go_router/go_router.dart';

class NoLoginCard extends ConsumerWidget {
  final Widget Function(UserInfo, WidgetRef) builder;
  final Widget Function(WidgetRef)? noLoginbuilder;
  const NoLoginCard({super.key, required this.builder, this.noLoginbuilder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听全局用户状态
    final userAsync = ref.watch(userInfoProvider);
    return userAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text("加载失败: $e")),
      data: (user) {
        if (user == null) {
          return noLoginbuilder?.call(ref) ??
              NoLoginWidget(
                onToLogin: () async {
                  if (ref.context.mounted) {
                    ref.context.push("/login");
                  }
                },
              );
        }
        return builder(user, ref);
      },
    );
  }
}

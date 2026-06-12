import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

/// EasyRefresh 全局配置
class AppEasyRefreshConfig {
  /// 默认头部配置
  static Header defaultHeader({
    String? refreshText = '下拉刷新',
    String? refreshingText = '正在刷新...',
    String? refreshedText = '刷新成功',
    String? failedText = '刷新失败',
  }) {
    return ClassicHeader(
      dragText: refreshText,
      armedText: '松开刷新',
      readyText: refreshingText,
      processingText: refreshingText,
      processedText: refreshedText,
      noMoreText: '没有更多',
      failedText: failedText,
      messageText: '更新于 %T',
      textStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      iconTheme: const IconThemeData(color: Colors.grey, size: 20),
      spacing: 10,
    );
  }

  /// 默认底部配置
  static Footer defaultFooter({
    String? loadText = '上拉加载',
    String? loadingText = '正在加载...',
    String? loadedText = '加载完成',
    String? failedText = '加载失败',
    String? noMoreText = '没有更多',
  }) {
    return ClassicFooter(
      dragText: loadText,
      armedText: '松开加载',
      readyText: loadingText,
      processingText: loadingText,
      processedText: loadedText,
      noMoreText: noMoreText,
      failedText: failedText,
      messageText: '更新于 %T',
      textStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      iconTheme: const IconThemeData(color: Colors.grey, size: 20),
      spacing: 10,
    );
  }
}

/// 通用下拉刷新组件
class AppEasyRefresh extends StatelessWidget {
  const AppEasyRefresh({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoad,
    this.header,
    this.footer,
    this.controller,
    this.enablePullDown = true,
    this.enablePullUp = false,
    this.onRefreshDone,
    this.onLoadDone,
  });

  /// 子组件
  final Widget child;

  /// 刷新回调
  final Future<void> Function()? onRefresh;

  /// 加载回调
  final Future<void> Function()? onLoad;

  /// 头部组件
  final Header? header;

  /// 底部组件
  final Footer? footer;

  /// 控制器
  final EasyRefreshController? controller;

  /// 是否启用下拉刷新
  final bool enablePullDown;

  /// 是否启用上拉加载
  final bool enablePullUp;

  /// 刷新完成回调
  final VoidCallback? onRefreshDone;

  /// 加载完成回调
  final VoidCallback? onLoadDone;

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: controller,
      header: enablePullDown
          ? header ?? AppEasyRefreshConfig.defaultHeader()
          : null,
      footer: enablePullUp
          ? footer ?? AppEasyRefreshConfig.defaultFooter()
          : null,
      onRefresh: onRefresh != null
          ? () async {
              await onRefresh!();
              onRefreshDone?.call();
            }
          : null,
      onLoad: onLoad != null
          ? () async {
              await onLoad!();
              onLoadDone?.call();
            }
          : null,
      child: child,
    );
  }
}

/// 带状态管理的下拉刷新组件
class AppEasyRefreshStateful extends StatefulWidget {
  const AppEasyRefreshStateful({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoad,
    this.header,
    this.footer,
    this.enablePullDown = true,
    this.enablePullUp = false,
    this.initialRefresh = false,
  });

  final Widget child;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoad;
  final Header? header;
  final Footer? footer;
  final bool enablePullDown;
  final bool enablePullUp;
  final bool initialRefresh;

  @override
  State<AppEasyRefreshStateful> createState() => _AppEasyRefreshStatefulState();
}

class _AppEasyRefreshStatefulState extends State<AppEasyRefreshStateful> {
  late final EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    if (widget.initialRefresh) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.callRefresh();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppEasyRefresh(
      controller: _controller,
      header: widget.header,
      footer: widget.footer,
      onRefresh: widget.onRefresh != null
          ? () async {
              await widget.onRefresh!();
              _controller.finishRefresh();
            }
          : null,
      onLoad: widget.onLoad != null
          ? () async {
              await widget.onLoad!();
              _controller.finishLoad();
            }
          : null,
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      child: widget.child,
    );
  }
}

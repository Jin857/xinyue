import 'package:flutter/material.dart';

/// 当前移动端设计基准，按常见 375dp 宽度设计稿接入。
const Size designSize = Size(375, 812);

/// 文字跟随较小屏幕维度适配，减少横竖屏或窄屏下字号过大的风险。
const bool minTextAdapt = true;

/// 允许分屏/横屏场景重新计算尺寸，Android/iOS 管理端仍只按移动端能力处理。
const bool splitScreenMode = true;

/// 管理端手机 UI 不随超宽屏无限放大，避免测试视口、横屏或平板预览下布局被撑坏。
const double maxScaleFactor = 1.15;

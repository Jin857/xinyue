import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xinyue/constant/app_shared.dart';
import 'package:xinyue/model/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userInfoProvider = AsyncNotifierProvider<UserInfoNotifier, UserInfo?>(() {
  return UserInfoNotifier();
});

class UserInfoNotifier extends AsyncNotifier<UserInfo?> {
  late SharedPreferences _sp;

  @override
  Future<UserInfo?> build() async {
    // 1. 初始化缓存
    _sp = await SharedPreferences.getInstance();
    // 2. 启动自动检测登录
    return await _checkLoginStatus();
  }

  /// 核心：检测当前是否登录（读缓存 + 后端验证Token）
  Future<UserInfo?> _checkLoginStatus() async {
    // 第一步：先读本地缓存
    final userJson = _sp.getString(shareUserInfo);
    if (userJson == null) {
      return null;
    }

    late UserInfo? user;
    try {
      user = UserInfo.fromJson(jsonDecode(userJson));
    } catch (e) {
      await _sp.remove(shareUserInfo);
      return null;
    }

    // 第三步：【关键】请求后端，验证Token是否有效
    try {
      await Future.delayed(Duration(seconds: 2));
      // bool isTokenValid = false;
      // if (isTokenValid) {
      //   return user;
      // } else {
      await _sp.remove(shareUserInfo);
      return user;
      // }
    } catch (e) {
      await _sp.remove(shareUserInfo);
      return null;
    }
  }

  /// ===================== 对外提供的核心方法 ===================== ///

  /// 登录
  Future<void> login(UserInfo user) async {
    state = const AsyncLoading();
    try {
      // 保存到本地
      await _sp.setString(shareUserInfo, jsonEncode(user.toJson()));
      // 更新状态
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// 登出
  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await _sp.remove(shareUserInfo);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// 更新用户信息
  Future<void> updateUser({String? nickName, Sex? sex}) async {
    final currentUser = state.value;
    if (currentUser == null) return;

    state = const AsyncLoading();
    try {
      final newUser = UserInfo(
        id: currentUser.id,
        nickName: nickName ?? currentUser.nickName,
        sex: sex ?? currentUser.sex,
        token: currentUser.token,
      );

      await _sp.setString(shareUserInfo, jsonEncode(newUser.toJson()));
      state = AsyncData(newUser);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// 手动刷新登录状态
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _checkLoginStatus());
  }
}

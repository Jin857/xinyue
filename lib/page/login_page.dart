import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xinyue/constant/app_router.dart' as router;
import 'package:xinyue/model/user_info.dart';
import 'package:go_router/go_router.dart';
import 'package:xinyue/provider/user/app_user_info.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 输入框控制器
  final TextEditingController _accountCtrl = TextEditingController();
  final TextEditingController _pwdCtrl = TextEditingController();

  // 加载状态
  bool _isLoading = false;
  // 密码可见性
  bool _pwdVisible = false;

  @override
  void dispose() {
    _accountCtrl.dispose();
    _pwdCtrl.dispose();
    super.dispose();
  }

  /// 模拟登录请求
  Future<void> _doLogin(WidgetRef ref) async {
    final account = _accountCtrl.text.trim();
    final pwd = _pwdCtrl.text.trim();

    // 简单表单校验
    if (account.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("请输入账号")));
      return;
    }
    if (pwd.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("请输入密码")));
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 模拟接口请求，替换为你的真实登录接口
      await Future.delayed(const Duration(seconds: 1));

      // 模拟接口返回用户数据
      final mockJson = {
        "id": "10001",
        "nickName": "测试用户",
        "sex": "male",
        "token": "mock_token_123456789",
      };
      final user = UserInfo.fromJson(mockJson);

      // 保存用户状态
      await ref.read(userInfoProvider.notifier).login(user);

      // 登录成功，跳转到首页
      if (mounted) {
        context.go(router.homePath);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("登录失败：${e.toString()}")));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("登录"),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 顶部Logo/标题区域
            const Center(
              child: Column(
                children: [
                  Icon(Icons.account_circle, size: 80, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    "账号登录",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "请输入您的账号和密码",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // 账号输入框
            TextField(
              controller: _accountCtrl,
              enabled: !_isLoading,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "账号",
                hintText: "请输入账号",
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 20),

            // 密码输入框
            TextField(
              controller: _pwdCtrl,
              enabled: !_isLoading,
              obscureText: !_pwdVisible,
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入密码",
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _pwdVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _pwdVisible = !_pwdVisible;
                    });
                  },
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 12),

            // 忘记密码
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _isLoading ? null : () {},
                child: const Text(
                  "忘记密码？",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 登录按钮
            Consumer(
              builder: (context, ref, child) {
                return SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : () => _doLogin(ref),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      elevation: 2,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Text(
                            "立即登录",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

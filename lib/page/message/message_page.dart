import 'package:flutter/material.dart';
import 'package:xinyue/components/no_login_card.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("消息"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Colors.grey.shade50,
      body: NoLoginCard(builder: (userInfo, ref) => _EmptyMessageView()),
    );
  }
}

/// 空消息页面
class _EmptyMessageView extends StatelessWidget {
  const _EmptyMessageView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.message_outlined, size: 100, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          Text(
            "暂无消息",
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

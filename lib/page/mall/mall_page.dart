import 'package:flutter/material.dart';
import 'package:xinyue/page/mall/mall_priducts.dart';

class MallPage extends StatelessWidget {
  final BuildContext scaffoldContext;
  const MallPage({super.key, required this.scaffoldContext});

  @override
  Widget build(BuildContext context) {
    return MallPriducts();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true, // 滑动到顶端时会固定住
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text("商城"),
            background: Image.asset("./imgs/sea.png", fit: BoxFit.cover),
          ),
          leading: IconButton(
            icon: Icon(Icons.person_2, color: Colors.black),
            onPressed: () {
              print("------>$scaffoldContext");
              Scaffold.of(scaffoldContext).openDrawer();
            },
          ),
        ),
      ],
    );
  }
}

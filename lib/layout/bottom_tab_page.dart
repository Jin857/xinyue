import 'package:flutter/material.dart';

class BottomTabPage extends StatefulWidget {
  final List<Widget> Function(BuildContext scaffoldContext) pageList;
  final List<BottomNavigationBarItem> tabs;
  final Widget? drawer;
  const BottomTabPage({
    super.key,
    required this.pageList,
    required this.tabs,
    this.drawer,
  });

  @override
  State<BottomTabPage> createState() => _BottomTabPageState();
}

class _BottomTabPageState extends State<BottomTabPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext scaffoldContext) {
          // ✅ 这里的 scaffoldContext 位于 Scaffold 之下
          return IndexedStack(
            index: _currentIndex,
            children: widget.pageList(scaffoldContext),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.tabs,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
      drawer: widget.drawer, //抽屉
    );
  }
}

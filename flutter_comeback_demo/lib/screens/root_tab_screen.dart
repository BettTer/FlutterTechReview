import 'package:flutter/material.dart';
import 'tab_a_screens.dart';
import 'tab_b_screens.dart';

class RootTabScreen extends StatefulWidget {
  const RootTabScreen({super.key});

  @override
  State<RootTabScreen> createState() => _RootTabScreenState();
}

class _RootTabScreenState extends State<RootTabScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const TabA_RootScreen(),
    const TabB_RootScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用 IndexedStack 保持 Tab 切换时的页面状态
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_upload),
            label: "Tab A (Write)",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Tab B (Read)",
          ),
        ],
      ),
    );
  }
}

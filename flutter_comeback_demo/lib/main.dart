import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/root_tab_screen.dart';

void main() {
  runApp(
    // 关键点：ProviderScope 必须包裹整个 App
    // 它是所有 Provider 状态的仓库 (Store)
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Structured Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const RootTabScreen(),
    );
  }
}

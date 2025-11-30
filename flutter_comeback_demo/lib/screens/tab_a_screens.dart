import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/post_provider.dart';

// Tab A 首页 (Title Page)
class TabA_RootScreen extends StatelessWidget {
  const TabA_RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tab A: Title Page"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 路由跳转到详情页
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TabA_DetailScreen(),
              ),
            );
          },
          child: const Text("Go to Fetch Page ->"),
        ),
      ),
    );
  }
}

// Tab A 详情页 (API 请求页)
class TabA_DetailScreen extends ConsumerWidget {
  const TabA_DetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Fetcher")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_download, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                // 调用 Provider 的逻辑
                final success = await ref
                    .read(postProvider.notifier)
                    .fetchAndSaveData();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success ? "Success! Saved." : "Failed"),
                    ),
                  );
                }
              },
              child: const Text("Fetch API & Save to Memory"),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                ref.read(postProvider.notifier).clearData();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Memory Cleared")));
              },
              child: const Text("Clear Memory"),
            ),
          ],
        ),
      ),
    );
  }
}

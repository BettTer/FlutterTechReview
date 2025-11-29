import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/post_provider.dart';
// 不需要引入 post.dart，因为 Dart 的类型推断通常能通过 provider 识别，
// 但为了显式引用 Post 类属性，建议引入，或者让 IDE 自动处理。

class TabB_RootScreen extends StatelessWidget {
  const TabB_RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tab B: Title Page"),
        backgroundColor: Colors.green.shade100,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TabB_ListScreen()),
            );
          },
          child: const Text("Go to List Page ->"),
        ),
      ),
    );
  }
}

class TabB_ListScreen extends ConsumerWidget {
  const TabB_ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听数据源
    final posts = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Data List (${posts.length})"),
        backgroundColor: Colors.green.shade100,
      ),
      body: posts.isEmpty
          ? const Center(
              child: Text(
                "No data in memory.\nGo to Tab A to fetch.",
                textAlign: TextAlign.center,
              ),
            )
          : ListView.separated(
              itemCount: posts.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  leading: CircleAvatar(child: Text("${post.id}")),
                  title: Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
    );
  }
}

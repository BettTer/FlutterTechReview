import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../models/post.dart';

// 定义一个 StateNotifier (业务逻辑核心)
class PostListNotifier extends Notifier<List<Post>> {
  @override
  List<Post> build() {
    return []; // 初始状态为空数组
  }

  // Action: 发送网络请求并更新状态
  Future<bool> fetchAndSaveData() async {
    try {
      print("🚀 [Provider] 开始请求 API...");
      final response = await Dio().get(
        'https://jsonplaceholder.typicode.com/posts',
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawList = response.data;
        final List<Post> posts = rawList
            .take(20)
            .map((e) => Post.fromJson(e))
            .toList();

        // 更新状态 (Immutable update)
        state = posts;

        print("✅ [Provider] 数据已保存到内存: ${state.length} 条");
        return true;
      }
      return false;
    } catch (e) {
      print("❌ [Provider] 请求失败: $e");
      return false;
    }
  }

  // Action: 清空数据
  void clearData() {
    state = [];
  }
}

// 全局 Provider 定义
final postProvider = NotifierProvider<PostListNotifier, List<Post>>(
  PostListNotifier.new,
);

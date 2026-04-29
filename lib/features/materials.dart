import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// 1. 投稿リストの状態を管理するクラス
class PostListNotifier extends StateNotifier<List<Post>> {
  PostListNotifier() : super([]); // 最初は空リスト

  // 投稿を追加するメソッド
  void addPost(Post post) {
    // state（現在のリスト）に新しい投稿を加えて、新しいリストとして上書きする
    state = [...state, post];
  }
}

// 2. 外部からこのクラスを操作するためのプロバイダー
final postListProvider = StateNotifierProvider<PostListNotifier, List<Post>>((
  ref,
) {
  return PostListNotifier();
});

class AppColors {
  // メインのテーマカラーなど
  static const Color mainBrown = Color(0xFF6B4E3D);
  static const Color accentPink = Color(0xFFF4A5B1);
  static const Color backgroundBeige = Color(0xFFFEF8F1);

  // カテゴリごとの色をMapで一括管理
  static const Map<String, Color> categoryColors = {
    '震災': Color(0xFFF2B186),
    '戦争': Color(0xFFB5C9A7),
    '人生': Color(0xFF6B4E3D),
    '恋愛': Color(0xFFF4A5B1),
    '雑談': Color(0xFFFAD28E),
    'その他': Color(0xFF2A5AB0),
  };

  // 安全に色を取得するためのメソッド
  static Color getCategoryColor(String category) {
    return categoryColors[category] ?? Colors.grey;
  }
}

//掲示板の投稿１つ分
class Post {
  final String category;
  final String dateTime;
  final String content;

  Post({required this.category, required this.dateTime, required this.content});
}

class AppAssets {
  //芝生画像
  static const String glass = 'assets/images/glass.png';
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hack1/features/board/postCard.dart';
import 'package:hack1/features/common/base_background.dart';
import 'package:hack1/features/materials.dart';
import 'package:hack1/features/board/board_detail_screen.dart';

class BoardScreen extends ConsumerStatefulWidget {
  final Map<String, Color> categoryColors;
  final bool showBackButton;

  const BoardScreen({
    super.key,
    required this.categoryColors,
    this.showBackButton = false,
  });

  @override
  ConsumerState<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends ConsumerState<BoardScreen> {
  // 現在選択されているカテゴリを保存する変数
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(postsStreamProvider);

    // カテゴリーカラー
    final Map<String, Color> categoryColors = widget.categoryColors;

    return BaseBackground(
      title: '掲示板',
      leading: widget.showBackButton ? commonBackButton(context) : null,
      child: Column(
        children: [
          // カテゴリフィルター
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // 横にスクロール
            padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
            child: Row(
              children: categoryColors.keys.map((category) {
                return _buildCategoryButton(category, categoryColors);
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: postsAsync.when(
              data: (posts) {
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    // カテゴリフィルターがかかっている場合の処理
                    if (selectedCategory != null &&
                        post.category != selectedCategory) {
                      return const SizedBox.shrink(); // 一致しなければ表示しない
                    }

                    // 投稿カードをタップしたときの処理
                    return PostCard(
                      category: post.category,
                      dateTime: post.dateTime,
                      content: post.content,
                      categoryColors: categoryColors,
                      onTap: () {
                        // 詳細画面に遷移
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardDetailScreen(post: post),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => const Center(child: Text('エラーが発生しました')),
            ),
          ),
        ],
      ),
    );
  }

  // カテゴリボタンを作るパーツ
  Widget _buildCategoryButton(String category, Map<String, Color> colorSet) {
    final Color themeColor = AppColors.getCategoryColor(category, colorSet);

    // selectedCategory が null でない、かつ今のカテゴリと一致しているか
    final bool isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            if (isSelected) {
              // 1. すでに選択されているボタンをもう一度押したら解除（nullにする）
              selectedCategory = null;
            } else {
              // 2. それ以外（未選択 or 別のボタン）を押したら、そのカテゴリを選択
              selectedCategory = category;
            }
          });
        },
        style: OutlinedButton.styleFrom(
          // 背景色：選択中ならカテゴリ色、そうでなければ白
          backgroundColor: isSelected ? themeColor : Colors.white,
          // 文字色：選択中なら白、そうでなければブラウン
          foregroundColor: isSelected ? Colors.white : AppColors.mainBrown,
          side: BorderSide(color: themeColor, width: 2.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}

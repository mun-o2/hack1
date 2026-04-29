import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hack1/features/materials.dart';

class SeniorBoardScreen extends ConsumerStatefulWidget {
  const SeniorBoardScreen({super.key});

  @override
  ConsumerState<SeniorBoardScreen> createState() => _SeniorBoardScreenState();
}

class _SeniorBoardScreenState extends ConsumerState<SeniorBoardScreen> {
  // 現在選択されているカテゴリを保存する変数
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postListProvider);

    final Map<String, dynamic> theme = ref.watch(colorThemeProvider);
    final Map<String, Color> categoryColors =
        theme['categories'] as Map<String, Color>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '掲示板',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.mainBrown,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundBeige,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: AppColors.backgroundBeige,
      body: Column(
        children: [
          //カテゴリフィルター
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
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                // カテゴリフィルターがかかっている場合の処理
                if (selectedCategory != null &&
                    post.category != selectedCategory) {
                  return const SizedBox.shrink(); // 一致しなければ表示しない
                }
                return postCard(
                  post.category,
                  post.dateTime,
                  post.content,
                  categoryColors,
                );
              },
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
              // すでに選択されているボタンをもう一度押したら解除（nullにする）
              selectedCategory = null;
            } else {
              // それ以外（未選択 or 別のボタン）を押したら、そのカテゴリを選択
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
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        ),
        child: Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  // 各投稿のパーツ
  Widget postCard(
    String category,
    String dateTime,
    String content,
    Map<String, Color> colorSet,
  ) {
    // カテゴリに応じた色を取得
    final Color themeColor = AppColors.getCategoryColor(category, colorSet);

    return Container(
      width: 340,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      padding: const EdgeInsets.fromLTRB(31, 22, 8, 19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mainBrown, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 上段：カテゴリと日時
          Row(
            children: [
              // カテゴリ
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: themeColor, width: 2),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20, // 文字サイズを大きく
                  ),
                ),
              ),
              const SizedBox(width: 30),
              // 日時
              Text(
                dateTime,
                style: const TextStyle(
                  color: AppColors.mainBrown,
                  fontSize: 20, // 文字サイズを大きく
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 下段：本文
          Text(
            content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.mainBrown,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

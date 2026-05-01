import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hack1/features/materials.dart';
import 'package:hack1/features/setting/base_background.dart';

import 'student_board_post.dart';

class StudentBoardScreen extends ConsumerStatefulWidget {
  const StudentBoardScreen({super.key});

  @override
  ConsumerState<StudentBoardScreen> createState() => _StudentBoardScreenState();
}

class _StudentBoardScreenState extends ConsumerState<StudentBoardScreen> {
  // 現在選択されているカテゴリを保存する変数
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postListProvider);

    //若者側はかわいいカラーで固定
    final categoryColors = AppColors.pastelCategoryColors;

    return BaseBackground(
      title: '掲示板',

      //投稿追加ボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 投稿作成画面（StudentBoardPost）を表示
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: Colors.transparent,
            builder: (context) {
              // 表示したい中身（作成したWidget）
              return const StudentBoardPost();
            },
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: AppColors.mainBrown, size: 32),
      ),
      child: Column(
        children: [
          //カテゴリフィルター呼び出し
          CategoryFilter(
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
            themeColors: AppColors.pastelCategoryColors,
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

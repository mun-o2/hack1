import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hack1/features/board/board_screen.dart';
import 'package:hack1/features/materials.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent,

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
      body: const BoardScreen(categoryColors: AppColors.pastelCategoryColors),
    );
  }
}

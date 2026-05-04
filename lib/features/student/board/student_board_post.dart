import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'board_writing_space.dart';
import 'package:flutter/material.dart';
import 'package:hack1/features/materials.dart';

class StudentBoardPost extends ConsumerStatefulWidget {
  const StudentBoardPost({super.key});

  @override
  ConsumerState<StudentBoardPost> createState() => _StudentBoardPostState();
}

class _StudentBoardPostState extends ConsumerState<StudentBoardPost> {
  String _enteredText = '';
  String _selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    //若者側はかわいいカラーで固定
    final pinkColor = AppColors.pastelPink;
    final categoryColors = AppColors.pastelCategoryColors;
    // 保存ボタン
    final saveButton = GestureDetector(
      onTap: () {
        if (_enteredText.isEmpty) {
          _showCustomToast(context, '本文を入力してください', pinkColor); //
          return;
        } else if (_enteredText.length > 50) {
          _showCustomToast(context, '50文字以内で入力してください', pinkColor);
          return;
        } else if (_selectedCategory.isEmpty) {
          _showCustomToast(context, 'カテゴリを選択してください', pinkColor);
          return;
        }

        final newPost = Post(
          category: _selectedCategory,
          dateTime: '4/30 12:00~14:00',
          content: _enteredText,
        );
        // データを追加
        ref.read(postListProvider.notifier).addPost(newPost);
        Navigator.pop(context); // 前の画面に戻る
      },
      child: Text(
        '保存',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: pinkColor,
        ),
      ),
    );

    // キャンセルボタン
    final cancelButton = GestureDetector(
      onTap: () => Navigator.pop(context), //画面を閉じる,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(color: pinkColor, shape: BoxShape.rectangle),
        child: const Icon(Icons.close, size: 20, color: Colors.white),
      ),
    );

    return Container(
      width: double.infinity,
      // 画面の高さの90%くらいに収める
      height: MediaQuery.of(context).size.height * 0.92,
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
      decoration: BoxDecoration(
        color: AppColors.backgroundBeige, // 背景色
        border: Border.all(
          color: AppColors.mainBrown, // AppColors.mainBrown があればそれを使う
          width: 1.0,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [cancelButton, saveButton],
          ),
          const SizedBox(height: 20),
          // 入力スペース
          BoardWritingSpace(onChanged: (text) => _enteredText = text),
          const SizedBox(height: 10),
          // カテゴリ選択
          CategorySelect(
            isMultiSelect: false, // 単一選択
            categoryColors: categoryColors,
            onChanged: (category) {
              setState(() {
                _selectedCategory = category as String; // Stringとして受け取る
              });
            },
          ),
        ],
      ),
    );
  }

  // 警告メッセージ
  void _showCustomToast(
    BuildContext context,
    String message,
    Color themeColor,
  ) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.4,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
    // Overlayに挿入
    overlay.insert(overlayEntry);

    // 1秒後に削除
    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }
}

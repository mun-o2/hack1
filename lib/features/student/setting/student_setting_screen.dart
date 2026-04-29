import 'package:flutter/material.dart';
import 'package:hack1/features/setting_screen.dart';
import 'package:hack1/features/materials.dart';

class StudentSettingScreen extends StatelessWidget {
  const StudentSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingScreen(
      additionalSettingContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '聞きたいジャンル',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.mainBrown,
            ),
          ),
          const SizedBox(height: 12),
          //_buildCategoryGrid(), // カテゴリ表示（共通パーツにすれば使い回せます）
        ],
      ),
    );
  }
}

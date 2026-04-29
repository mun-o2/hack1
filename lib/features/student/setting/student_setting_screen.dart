import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hack1/features/setting_screen.dart';
import 'package:hack1/features/materials.dart';

class StudentSettingScreen extends ConsumerStatefulWidget {
  const StudentSettingScreen({super.key});

  @override
  ConsumerState<StudentSettingScreen> createState() =>
      _StudentSettingScreenState();
}

class _StudentSettingScreenState extends ConsumerState<StudentSettingScreen> {
  List<String> _mySelectedList = [];

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(colorThemeProvider);
    final categoryColors = theme['categories'] as Map<String, Color>;

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
          const SizedBox(height: 8),
          CategorySelect(
            isMultiSelect: true, // 複数選択
            initialSelected: _mySelectedList, // すでに保存されているリストがあれば渡す
            categoryColors: categoryColors,
            onChanged: (list) {
              setState(() {
                _mySelectedList = list as List<String>; // Listとして受け取る
              });
            },
          ),
        ],
      ),
    );
  }
}

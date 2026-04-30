import 'package:flutter/material.dart';
import 'package:hack1/features/setting_screen.dart';
import 'package:hack1/features/materials.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeniorSettingScreen extends ConsumerStatefulWidget {
  const SeniorSettingScreen({super.key});

  @override
  ConsumerState<SeniorSettingScreen> createState() =>
      _SeniorSettingScreenState();
}

class _SeniorSettingScreenState extends ConsumerState<SeniorSettingScreen> {
  List<String> _mySelectedList = [];

  @override
  Widget build(BuildContext context) {
    // 現在のモードに応じて使うカラーセットを選ぶ
    final isHighContrast = ref.watch(isHighContrastProvider);

    final currentCategoryColors = isHighContrast
        ? AppColors.contrastCategoryColors
        : AppColors.pastelCategoryColors;

    return SettingScreen(
      additionalSettingContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '話せるジャンル',
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
            categoryColors: currentCategoryColors,
            onChanged: (list) {
              setState(() {
                _mySelectedList = list as List<String>; // Listとして受け取る
              });
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'テーマ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.mainBrown,
            ),
          ),
          const SizedBox(height: 8),
          _colorModeButton(
            label: '見やすい',
            color: Color(0xFF55508B),
            isSelected: isHighContrast,
            onTap: () {
              ref.read(isHighContrastProvider.notifier).state = true;
            },
          ),
          const SizedBox(height: 12),
          _colorModeButton(
            label: 'かわいい',
            color: Color(0xFFF2B186),
            isSelected: !isHighContrast,
            onTap: () {
              ref.read(isHighContrastProvider.notifier).state = false;
            },
          ),
        ],
      ),
    );
  }

  // 色変更用ボタン
  Widget _colorModeButton({
    required String label,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.mainBrown,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

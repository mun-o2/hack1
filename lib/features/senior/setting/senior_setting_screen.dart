import 'package:flutter/material.dart';
import 'package:hack1/features/setting_screen.dart';
import 'package:hack1/features/materials.dart';

class SeniorSettingScreen extends StatefulWidget {
  const SeniorSettingScreen({super.key});

  @override
  State<SeniorSettingScreen> createState() => _SeniorSettingScreenState();
}

class _SeniorSettingScreenState extends State<SeniorSettingScreen> {
  List<String> _mySelectedList = [];

  @override
  Widget build(BuildContext context) {
    return SettingScreen(
      additionalSettingContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '話せるジャンル',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.mainBrown,
            ),
          ),
          const SizedBox(height: 12),
          CategorySelect(
            isMultiSelect: true, // 複数選択
            initialSelected: _mySelectedList, // すでに保存されているリストがあれば渡す
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
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/features/materials.dart';
import 'package:hack1/features/setting/base_background.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 31),
            child: Column(
              children: [
                const SizedBox(height: 60),

                // 上のお知らせバー(仮)
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: const Text(
                    '今日は、どんなお話を\n聞いてみようかな？',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.mainBrown,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 55),

                HomeMenuCard(
                  label: '掲示板',
                  subLabel: '質問をする',
                  onTap: () => context.go('/student/board'),
                  icon: Icons.message,
                  themeColor: AppColors.pastelPink,
                ),

                const SizedBox(height: 34),

                HomeMenuCard(
                  label: '思い出',
                  subLabel: 'お話の記録を見る',
                  onTap: () => context.go('/student/memory'),
                  icon: Icons.auto_stories,
                  themeColor: AppColors.pastelYellow,
                ),

                const SizedBox(height: 34),

                HomeMenuCard(
                  label: '設定',
                  subLabel: 'アカウント設定',
                  onTap: () => context.go('/student/setting'),
                  icon: Icons.manage_accounts_outlined,
                  themeColor: AppColors.pastelGreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

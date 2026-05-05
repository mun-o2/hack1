import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/features/common/base_background.dart';
import 'package:hack1/features/materials.dart';

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
                SizedBox(
                  height: 160,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // 白いボックス
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 130, // 元々の高さ
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
                      ),

                      // ひつじ
                      Positioned(
                        left: -15,
                        bottom: 0,
                        child: Image.asset(
                          'assets/images/right.png',
                          height: 120, // サイズ
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

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

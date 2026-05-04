import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/app/base_background.dart';
import 'package:hack1/features/materials.dart';

class SeniorHomeScreen extends ConsumerWidget {
  const SeniorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 現在の色セットを監視（watch）する
    final theme = ref.watch(colorThemeProvider);

    return BaseBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          // Navigate to the onboarding screen
          onPressed: () {
            context.go('/role');
          },
          child: const Icon(Icons.home),
        ),
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
                  subLabel: '若者の投稿を見る',
                  themeColor: theme['pink'] as Color,
                  onTap: () => context.push('/senior/board'),
                  icon: Icons.message,
                ),

                const SizedBox(height: 34),

                HomeMenuCard(
                  label: '思い出',
                  subLabel: 'お話の記録を見る',
                  themeColor: theme['yellow'] as Color,
                  onTap: () => context.push('/senior/memory'),
                  icon: Icons.auto_stories,
                ),

                const SizedBox(height: 34),

                HomeMenuCard(
                  label: '設定',
                  subLabel: 'アカウント設定',
                  themeColor: theme['green'] as Color,
                  onTap: () => context.push('/senior/setting'),
                  icon: Icons.manage_accounts_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

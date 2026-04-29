import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/features/materials.dart';

class SeniorHomeScreen extends StatelessWidget {
  const SeniorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
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

              _SeniorMenuCard(
                label: '掲示板',
                subLabel: '若者の投稿を見る',
                onTap: () => context.push('/senior/board'),
                icon: Icons.message,
                themeColor: AppColors.accentPink,
              ),

              const SizedBox(height: 34),

              _SeniorMenuCard(
                label: '思い出',
                subLabel: 'お話の記録を見る',
                onTap: () => context.push('/senior/memory'),
                icon: Icons.photo,
                themeColor: AppColors.accentYellow,
              ),

              const SizedBox(height: 34),

              _SeniorMenuCard(
                label: '設定',
                subLabel: 'アカウント設定',
                onTap: () => context.push('/senior/setting'),
                icon: Icons.settings,
                themeColor: AppColors.accentGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeniorMenuCard extends StatelessWidget {
  final String label;
  final String subLabel;
  final VoidCallback onTap;
  final IconData icon;
  final Color themeColor;

  const _SeniorMenuCard({
    required this.label,
    required this.subLabel,
    required this.onTap,
    required this.icon,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 115,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: themeColor, width: 3),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Row(
          children: [
            Icon(icon, size: 70, color: themeColor),

            const SizedBox(width: 65),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainBrown,
                  ),
                ),
                Text(
                  subLabel,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainBrown,
                  ),
                ),
              ],
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SeniorHomeScreen extends StatelessWidget {
  const SeniorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(height: 20),

              // 上のお知らせバー(仮)
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF498854),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: const Text(
                  '戦争について聞きたい人がいます',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 160),

              _SeniorMenuCard(
                label: '掲示板',
                onTap: () => context.push('/senior/board'),
                icon: Icons.message,
              ),

              const SizedBox(height: 24),

              _SeniorMenuCard(
                label: '思い出',
                onTap: () => context.push('/senior/memory'),
                icon: Icons.photo,
              ),

              const SizedBox(height: 24),

              _SeniorMenuCard(
                label: '設定',
                onTap: () => context.push('/senior/setting'),
                icon: Icons.settings,
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
  final VoidCallback onTap;
  final IconData icon;

  const _SeniorMenuCard({
    required this.label,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 152,
        decoration: BoxDecoration(
          color: const Color(0xFFDE6A1D),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Row(
          children: [
            Icon(icon, size: 48, color: Colors.white),

            const Spacer(),

            Text(
              label,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

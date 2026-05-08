import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/features/student/main/widgets/nav_bar.dart';

class StudentMainTab extends StatelessWidget {
  // ? navigationShell
  const StudentMainTab({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ナビゲーションバーの背景透過
      extendBody: false,
      body: navigationShell,

      /*
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/role'),
        child: const Icon(Icons.home),
      ),
      */

      // ホーム画面以外のときにのみナビゲーションバーを表示
      bottomNavigationBar: navigationShell.currentIndex == 0
          ? null
          : StudentBottomNavBar(
              selectedIndex: navigationShell.currentIndex,
              onTap: (index) {
                navigationShell.goBranch(index);
              },
            ),
    );
  }
}

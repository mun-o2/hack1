import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/features/student/main/widgets/nav_bar.dart';

class StudentMainTab extends StatelessWidget {
  // ? navigationShell をコンストラクタで受け取る
  const StudentMainTab({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/role'),
        child: const Icon(Icons.home),
      ),

      bottomNavigationBar: StudentBottomNavBar(
        selectedIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            // すでにそのタブにいる時にもう一度タップしたら、最初の画面に戻る設定（お好みで）
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

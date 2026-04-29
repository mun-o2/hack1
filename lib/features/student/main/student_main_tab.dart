import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/features/student/board/student_board_screen.dart';
import 'package:hack1/features/student/home/student_home_screen.dart';
import 'package:hack1/features/student/main/widgets/nav_bar.dart';
import 'package:hack1/features/student/memory/student_memory_screen.dart';
import 'package:hack1/features/student/setting/student_setting_screen.dart';

class StudentMainTab extends StatefulWidget {
  const StudentMainTab({super.key});

  @override
  State<StudentMainTab> createState() => _StudentMainTabState();
}

class _StudentMainTabState extends State<StudentMainTab> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = const [
      StudentHomeScreen(),
      StudentBoardScreen(),
      StudentMemoryScreen(),
      StudentSettingScreen(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      //ロール選択に戻るボタンを左下に移動させました
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        // Navigate to the onboarding screen
        onPressed: () {
          context.go('/role');
        },
        child: const Icon(Icons.home),
      ),
      bottomNavigationBar: StudentBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

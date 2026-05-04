import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/features/materials.dart';
import 'package:hack1/features/student/main/widgets/nav_bar.dart';

class StudentMainTab extends StatelessWidget {
  // ? navigationShell ���R���X�g���N�^�Ŏ󂯎��
  const StudentMainTab({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,

      //���[���I���ɖ߂�{�^���������Ɉړ������܂���
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
            // ���łɂ��̃^�u�ɂ��鎞�ɂ�����x�^�b�v������A�ŏ��̉�ʂɖ߂�ݒ�i���D�݂Łj
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:hack1/features/onboarding/role_select_screen.dart';
import 'package:hack1/features/senior/board/senior_board_screen.dart';

import 'package:hack1/features/senior/home/senior_home_screen.dart';
import 'package:hack1/features/senior/memory/senior_memory_screen.dart';
import 'package:hack1/features/senior/setting/senior_setting_screen.dart';
import 'package:hack1/features/student/main/student_main_tab.dart';

final GoRouter router = GoRouter(
  initialLocation: '/role',
  routes: [
    GoRoute(
      path: '/role',
      builder: (context, state) => const RoleSelectScreen(),
    ),
    GoRoute(
      path: '/student',
      builder: (context, state) => const StudentMainTab(),
    ),
    GoRoute(
      path: '/senior',
      builder: (context, state) => const SeniorHomeScreen(),
    ),
    GoRoute(
      path: '/senior/board',
      builder: (context, state) => const SeniorBoardScreen(),
    ),
    GoRoute(
      path: '/senior/memory',
      builder: (context, state) => const SeniorMemoryScreen(),
    ),
    GoRoute(
      path: '/senior/setting',
      builder: (context, state) => const SeniorSettingScreen(),
    ),
  ],
);

import 'package:go_router/go_router.dart';
import 'package:hack1/features/onboarding/role_select_screen.dart';
import 'package:hack1/features/senior/board/senior_board_screen.dart';

import 'package:hack1/features/senior/home/senior_home_screen.dart';
import 'package:hack1/features/senior/memory/senior_memory_screen.dart';
import 'package:hack1/features/senior/setting/senior_setting_screen.dart';
import 'package:hack1/features/student/board/student_board_screen.dart';
import 'package:hack1/features/student/home/student_home_screen.dart';
import 'package:hack1/features/student/main/student_main_tab.dart';
import 'package:hack1/features/student/memory/student_memory_screen.dart';
import 'package:hack1/features/student/setting/student_setting_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/role',
  routes: [
    GoRoute(
      path: '/role',
      builder: (context, state) => const RoleSelectScreen(),
    ),

    //若者用のナビゲーションバー付きルート
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // navigationShell を渡すことで、今の画面がどれかを StudentMainTab が知れるようになります
        return StudentMainTab(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/student',
              builder: (context, state) =>
                  const StudentHomeScreen(), // ホーム画面単体のWidget
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/student/board',
              builder: (context, state) => const StudentBoardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/student/memory',
              builder: (context, state) => const StudentMemoryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/student/setting',
              builder: (context, state) => const StudentSettingScreen(),
            ),
          ],
        ),
      ],
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

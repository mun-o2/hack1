import 'package:go_router/go_router.dart';
import 'package:hack1/features/call/after_call_screen.dart';
import 'package:hack1/features/call/call_screen.dart';
import 'package:hack1/features/onboarding/initial_setting_screen.dart';
import 'package:hack1/features/onboarding/onboarding_screen.dart';
import 'package:hack1/features/onboarding/role_select_screen.dart';
import 'package:hack1/features/splash/splash_screen.dart';
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
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/role',
      builder: (context, state) => const RoleSelectScreen(),
    ),

    //��җp�̃i�r�Q�[�V�����o�[�t�����[�g
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // navigationShell ��n�����ƂŁA���̉�ʂ��ǂꂩ�� StudentMainTab ���m���悤�ɂȂ�܂�
        return StudentMainTab(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/student',
              builder: (context, state) =>
                  const StudentHomeScreen(), // �z�[����ʒP�̂�Widget
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
      path: '/initial/student',
      builder: (context, state) => const InitialSettingScreen(isSenior: false),
    ),
    GoRoute(
      path: '/initial/senior',
      builder: (context, state) => const InitialSettingScreen(isSenior: true),
    ),
    GoRoute(
      path: '/student/board',
      builder: (context, state) => const StudentBoardScreen(),
    ),
    GoRoute(
      path: '/student/memory',
      builder: (context, state) => const StudentMemoryScreen(),
    ),
    GoRoute(
      path: '/student/setting',
      builder: (context, state) => const StudentSettingScreen(),
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
    GoRoute(
      path: '/call/:postId',
      builder: (context, state) {
        final postId = state.pathParameters['postId']!;

        return CallPage(postId: postId);
      },
    ),
    GoRoute(
      path: '/after-call/:channelName',
      builder: (context, state) {
        final channelName = state.pathParameters['channelName']!;

        return AfterCallMessageScreen(channelName: channelName);
      },
    ),
  ],
);

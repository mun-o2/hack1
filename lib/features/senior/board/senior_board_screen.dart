import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hack1/features/board/board_screen.dart';
import 'package:hack1/features/materials.dart';

class SeniorBoardScreen extends ConsumerWidget {
  const SeniorBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> theme = ref.watch(colorThemeProvider);
    final Map<String, Color> categoryColors =
        theme['categories'] as Map<String, Color>;

    return BoardScreen(categoryColors: categoryColors, showBackButton: true);
  }
}

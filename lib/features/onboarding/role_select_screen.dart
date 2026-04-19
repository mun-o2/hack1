import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/student');
              },
              child: const Text('大学生'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/senior');
              },
              child: const Text('高齢者'),
            ),
          ],
        ),
      ),
    );
  }
}

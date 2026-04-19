import 'package:flutter/material.dart';

class SeniorBoardScreen extends StatelessWidget {
  const SeniorBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('掲示板一覧', style: TextStyle(fontSize: 32))),
    );
  }
}

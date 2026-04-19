import 'package:flutter/material.dart';

class SeniorMemoryScreen extends StatelessWidget {
  const SeniorMemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('記憶の整理', style: TextStyle(fontSize: 32))),
    );
  }
}

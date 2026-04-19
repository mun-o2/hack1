import 'package:flutter/material.dart';

class SeniorSettingScreen extends StatelessWidget {
  const SeniorSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('設定', style: TextStyle(fontSize: 32))),
    );
  }
}

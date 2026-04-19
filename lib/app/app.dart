import 'package:flutter/material.dart';
import 'router.dart';

class LivingRoomApp extends StatelessWidget {
  const LivingRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hack1/app/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,

      theme: ThemeData(
        fontFamily: 'ZenMaruGothic',
        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // ←これで白になる
          elevation: 0, // 影消す（スッキリ）
          iconTheme: IconThemeData(color: Colors.black), // 戻るボタン黒に
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

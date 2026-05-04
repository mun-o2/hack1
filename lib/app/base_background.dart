import 'package:hack1/features/materials.dart';
import 'package:flutter/material.dart';

class BaseBackground extends StatelessWidget {
  final Widget child;
  final String? title; // ? AppBarのタイトル。nullのときはAppBar自体を表示しない
  final Widget? floatingActionButton; // ? FloatingActionButton。nullのときは表示しない
  final Widget? leading; // ? AppBarの左側に表示するWidget。nullのときは表示しない

  const BaseBackground({
    super.key,
    required this.child,
    this.title,
    this.floatingActionButton,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: AppColors.backgroundBeige),
        // 画面下部の草のイラスト
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset('assets/images/grass.png', fit: BoxFit.cover),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          // AppBarはtitleがnullのときは表示しない
          appBar: title == null
              ? null
              : AppBar(
                  title: Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainBrown,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  leading: leading,
                  automaticallyImplyLeading: leading != null,
                ),
          body: child,
          floatingActionButton: floatingActionButton,
        ),
      ],
    );
  }
}

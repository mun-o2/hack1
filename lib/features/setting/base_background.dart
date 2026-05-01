import 'package:hack1/features/materials.dart';
import 'package:flutter/material.dart';

class BaseBackground extends StatelessWidget {
  final Widget child;
  final String? title; //画面上部タイトル
  final Widget? floatingActionButton; //ボタン（若者の掲示板投稿追加ボタン）
  final Widget? leading; //左上の戻るボタン

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
        // 芝生画像
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset('assets/images/grass.png', fit: BoxFit.cover),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          //titleがある時だけAppBarを表示
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

import 'package:flutter/material.dart';
import 'package:hack1/features/call/call_screen.dart';
import 'package:hack1/features/materials.dart';

class StudentBoardDetailScreen extends StatelessWidget {
  final String category;
  final String dateTime;
  final String content;

  const StudentBoardDetailScreen({
    super.key,
    required this.category,
    required this.dateTime,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      body: SafeArea(
        child: Column(
          children: [
            // 戻るボタン + タイトル
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.mainBrown,
                    ),
                  ),

                  const Expanded(
                    child: Text(
                      '掲示板',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainBrown,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // 戻るボタンのスペースを確保
                ],
              ),
            ),

            const SizedBox(height: 60),

            // 投稿カード
            Container(
              width: 280,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.mainBrown, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainBrown,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    dateTime,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.mainBrown,
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.mainBrown,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // お話をするボタン
            ElevatedButton(
              onPressed: () {
                // TODO: お話をするボタンの処理
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CallPage(channelName: 'test'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainBrown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'お話をする',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const Spacer(),

            // ひつじ + 芝生画像
            // TODO: 画像のパス
          ],
        ),
      ),
    );
  }
}

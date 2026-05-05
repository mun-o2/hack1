import 'package:flutter/material.dart';
import 'package:hack1/features/materials.dart';

// 掲示板の投稿カードウィジェット
class PostCard extends StatelessWidget {
  final String category;
  final String dateTime;
  final String content;
  final Map<String, Color> categoryColors;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.category,
    required this.dateTime,
    required this.content,
    required this.categoryColors,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = AppColors.getCategoryColor(category, categoryColors);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 340,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        padding: const EdgeInsets.fromLTRB(31, 22, 8, 19),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.mainBrown, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Text(
                  dateTime,
                  style: const TextStyle(
                    color: AppColors.mainBrown,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                color: AppColors.mainBrown,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

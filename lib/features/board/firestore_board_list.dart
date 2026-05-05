import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestorePostList extends StatelessWidget {
  final String? selectedCategory;
  final Map<String, Color> categoryColors;
  final Widget Function(
    String category,
    String dateTime,
    String content,
    Map<String, Color> categoryColors,
  )
  postCard;

  const FirestorePostList({
    super.key,
    required this.selectedCategory,
    required this.categoryColors,
    required this.postCard,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        // エラー処理とローディング処理
        if (snapshot.hasError) {
          return const Center(child: Text('読み込みに失敗しました'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Center(child: Text('まだ投稿がありません'));
        }

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;

            final category = data['category'] ?? '';
            final dateTime = data['dateTime'] ?? '';
            final content = data['content'] ?? '';

            // カテゴリフィルターがかかっている場合の処理
            if (selectedCategory != null && category != selectedCategory) {
              return const SizedBox.shrink();
            }

            return postCard(category, dateTime, content, categoryColors);
          },
        );
      },
    );
  }
}

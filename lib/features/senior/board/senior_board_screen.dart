import 'package:flutter/material.dart';

class SeniorBoardScreen extends StatefulWidget {
  const SeniorBoardScreen({super.key});

  @override
  State<SeniorBoardScreen> createState() => _SeniorBoardScreenState();
}

class _SeniorBoardScreenState extends State<SeniorBoardScreen> {
  // 現在選択されているカテゴリを保存する変数
  String? selectedCategory;

  //カテゴリごとの色を定義
  static const Map<String, Color> categoryColors = {
    '震災': Color(0xFFF2B186),
    '戦争': Color(0xFFB5C9A7),
    '人生': Color(0xFF6B4E3D),
    '恋愛': Color(0xFFF4A5B1),
    '雑談': Color(0xFFFAD28E),
    'その他': Color(0xFF2A5AB0),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '掲示板',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6B4E3D),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFEF8F1),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: const Color(0xFFFEF8F1),
      body: Column(
        children: [
          //カテゴリフィルター
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // 横にスクロール
            padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
            child: Row(
              children: categoryColors.keys.map((category) {
                return _buildCategoryButton(category);
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                if (selectedCategory == null || selectedCategory == '震災')
                  postCard(
                    '震災',
                    '4/21 17:00~18:00',
                    '東日本大震災についてのお話をぜひ聴かせていただきたいです。',
                  ),

                if (selectedCategory == null || selectedCategory == '戦争')
                  postCard(
                    '戦争',
                    '4/30 12:00~18:00',
                    '戦争についてのお話をぜひ聴かせていただきたいです。',
                  ),

                if (selectedCategory == null || selectedCategory == '恋愛')
                  postCard(
                    '恋愛',
                    '4/18 17:00~20:00',
                    '好きな人についてのお話をぜひ聴かせていただきたいです。',
                  ),

                if (selectedCategory == null || selectedCategory == '人生')
                  postCard('人生', '4/29 19:00~21:00', '予備投稿'),

                if (selectedCategory == null || selectedCategory == 'その他')
                  postCard('その他', '4/16 12:00~17:00', '予備投稿'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // カテゴリボタンを作るパーツ
  Widget _buildCategoryButton(String category) {
    final Color themeColor = categoryColors[category] ?? Colors.grey;

    // selectedCategory が null でない、かつ今のカテゴリと一致しているか
    final bool isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            if (isSelected) {
              // 1. すでに選択されているボタンをもう一度押したら解除（nullにする）
              selectedCategory = null;
            } else {
              // 2. それ以外（未選択 or 別のボタン）を押したら、そのカテゴリを選択
              selectedCategory = category;
            }
          });
        },
        style: OutlinedButton.styleFrom(
          // 背景色：選択中ならカテゴリ色、そうでなければ白
          backgroundColor: isSelected ? themeColor : Colors.white,
          // 文字色：選択中なら白、そうでなければブラウン
          foregroundColor: isSelected ? Colors.white : const Color(0xFF6B4E3D),
          side: BorderSide(color: themeColor, width: 2.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  // 各投稿のパーツ
  Widget postCard(String category, String dateTime, String content) {
    // カテゴリに応じた色を取得
    final Color themeColor = categoryColors[category] ?? Colors.grey;

    return Container(
      width: 340,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      padding: const EdgeInsets.fromLTRB(31, 22, 8, 19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF6B4E3D), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 上段：カテゴリと日時
          Row(
            children: [
              // カテゴリ
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: themeColor, width: 2),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20, // 文字サイズを大きく
                  ),
                ),
              ),
              const SizedBox(width: 30),
              // 日時
              Text(
                dateTime,
                style: const TextStyle(
                  color: Color(0xFF6B4E3D),
                  fontSize: 20, // 文字サイズを大きく
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 下段：本文
          Text(
            content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF6B4E3D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

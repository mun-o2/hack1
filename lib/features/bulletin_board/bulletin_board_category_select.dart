import 'package:flutter/material.dart';

// ignore: camel_case_types
class bulletin_board_category_select extends StatefulWidget {
  const bulletin_board_category_select({super.key});

  @override
  State<bulletin_board_category_select> createState() =>
      _bulletin_board_category_selectState();
}

// ignore: camel_case_types
class _bulletin_board_category_selectState
    extends State<bulletin_board_category_select> {
  // 現在選択されているカテゴリ名を保持
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    final categories = GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true, // 内容の高さに合わせる
      physics: const NeverScrollableScrollPhysics(), // この中ではスクロールしない
      crossAxisCount: 2, // 2列
      mainAxisSpacing: 20, // 縦の隙間
      crossAxisSpacing: 20, // 横の隙間
      childAspectRatio: 1.8, // ボタンの横長具合
      children: [
        // 1行目
        categoryButton('震災', const Color(0xFFDE6A1D)),
        categoryButton('戦争', const Color(0xFF4A8854)),
        // 2行目
        categoryButton('人生', const Color(0xFF80695A)),
        categoryButton('恋愛', const Color(0xFFC38297)),
        // 3行目
        categoryButton('雑談', const Color(0xFFCCAA25)),
        categoryButton('その他', const Color(0xFF1D3449)),
      ],
    );

    final col = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('カテゴリ', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        categories,
      ],
    );
    final con = Container(
      margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: col,
    );
    return con;
  }

  Widget categoryButton(String label, Color color) {
    // 自分が選ばれているかどうか判定
    final bool isSelected = (selectedCategory == label);
    return GestureDetector(
      onTap: () {
        setState(() {
          //もう一度タップすると選択解除する
          if (selectedCategory == label) {
            print('選択解除：$selectedCategory');
            selectedCategory = ''; // 空にする（解除）
          } else {
            selectedCategory = label; // 選択
            print('選択したカテゴリ：$selectedCategory');
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // 選ばれているなら元の色(100%)、選ばれていなければ透明度50%にする
          color: isSelected ? color : color.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            //影つけたけど透明度で調整してるから暗くなっちゃって一旦やめた
            /*
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
            */
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 25,
            // ignore: deprecated_member_use
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

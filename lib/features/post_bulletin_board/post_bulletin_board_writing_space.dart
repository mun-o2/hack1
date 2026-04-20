import 'package:flutter/material.dart';

class PostBulletinBoardWritingSpace extends StatefulWidget {
  const PostBulletinBoardWritingSpace({super.key});

  @override
  State<PostBulletinBoardWritingSpace> createState() =>
      _PostBulletinBoardWritingSpaceState();
}

class _PostBulletinBoardWritingSpaceState
    extends State<PostBulletinBoardWritingSpace> {
  //コントローラー
  final TextEditingController _controller = TextEditingController();
  int _currentLength = 0; // 現在の文字数
  final int _maxLength = 50; // 最大文字数

  @override
  void dispose() {
    _controller.dispose(); // メモリ節約のため使い終わったら破棄
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 文字数オーバーしているか判定
    bool isOverLimit = _currentLength > _maxLength;

    final textField = SizedBox(
      height: 250,
      child: TextField(
        controller: _controller, // コントローラーをセット
        maxLines: 12,
        minLines: 12,
        // 文字が入力されるたびに呼ばれる
        onChanged: (text) {
          setState(() {
            _currentLength = text.length;
          });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // 入力欄の中の色（通常時）
          focusColor: Colors.white, //入力欄の色（入力中）

          hoverColor: Colors.white, //カーソルを合わせたとき（Chrome時）
          //通常時
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xFFE6E9ED), width: 1.0),
          ),
          //入力中のとき（どちらにせよ一緒）
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xFFE6E9ED), width: 1.0),
          ),

          counterText: '', //カウンター表示
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '本文',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          textField,
          //カウント表示部分
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$_currentLength', // 現在の文字数
                      style: TextStyle(
                        // オーバーしたら赤、そうでなければグレー
                        color: isOverLimit ? Color(0xFFDE6A1D) : Colors.grey,
                        fontWeight: isOverLimit
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: ' / $_maxLength文字', // 残りの部分は常にグレー
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

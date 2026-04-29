import 'package:flutter/material.dart';
import 'package:hack1/features/materials.dart';

class BoardWritingSpace extends StatefulWidget {
  // コンストラクタで callback 関数を受け取る
  final Function(String) onChanged;
  const BoardWritingSpace({super.key, required this.onChanged});

  @override
  State<BoardWritingSpace> createState() => _BoardWritingSpaceState();
}

class _BoardWritingSpaceState extends State<BoardWritingSpace> {
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
    bool isOverLimit = _currentLength > _maxLength;

    final textField = Stack(
      children: [
        SizedBox(
          height: 250,
          child: TextField(
            onChanged: (text) {
              setState(() {
                _currentLength = text.length;
              });
              widget.onChanged(text);
            },
            controller: _controller,
            maxLines: 10,
            minLines: 10,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _currentLength > _maxLength
                  ? AppColors.pastelPink
                  : AppColors.mainBrown,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFFFEFE),

              contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 45),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: AppColors.backgroundBeige,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: AppColors.backgroundBeige,
                  width: 1.0,
                ),
              ),
              counterText: '', // デフォルトのカウンターは非表示
            ),
          ),
        ),

        // カウンター
        Positioned(
          right: 20,
          bottom: 15,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$_currentLength',
                  style: TextStyle(
                    color: isOverLimit ? AppColors.pastelPink : Colors.grey,
                    fontWeight: isOverLimit
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: ' / $_maxLength文字',
                  style: const TextStyle(
                    color: AppColors.mainBrown,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return Container(
      //キャンセルボタンたちとのスペース調整はここで
      margin: const EdgeInsets.fromLTRB(8, 40, 8, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '本文',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF80695A).withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8), // タイトルと入力欄の隙間
          textField,
        ],
      ),
    );
  }
}

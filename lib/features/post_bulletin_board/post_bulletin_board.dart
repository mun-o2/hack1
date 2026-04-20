import 'post_bulletin_board_category_select.dart';
import 'post_bulletin_board_writing_space.dart';
import 'package:flutter/material.dart';

class PostBulletinBoard extends StatelessWidget {
  const PostBulletinBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final writingSpace = PostBulletinBoardWritingSpace();
    final categorySelect = PostBulletinBoardCategorySelect();

    final save = GestureDetector(
      onTap: () {
        print('保存');
      },
      child: Text(
        '保存',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFFDE6A1D),
        ),
      ),
    );

    final cancelButton = GestureDetector(
      onTap: () {
        print('キャンセル');
      },
      child: Container(
        width: 25,
        height: 25,
        color: Color(0xFFDE6A1D),
        child: const Icon(Icons.close, size: 20, color: Colors.white),
      ),
    );

    final head = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [cancelButton, save],
    );

    final all = Column(children: [head, writingSpace, categorySelect]);

    final con = Container(
      width: 400,
      height: 830,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: BoxDecoration(
        color: Color(0xFFF3F3F3),
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(20),
          topEnd: Radius.circular(20),
        ),
      ),
      child: all,
    );

    return Scaffold(
      //キーボードが出ても画面をリサイズ（押し上げ）しない
      resizeToAvoidBottomInset: false,
      body: Align(alignment: Alignment.bottomCenter, child: con),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hack1/features/materials.dart';

class BoardCategorySelect extends StatefulWidget {
  final Function(String) onChanged;
  const BoardCategorySelect({super.key, required this.onChanged});

  @override
  State<BoardCategorySelect> createState() => _BoardCategorySelect();
}

class _BoardCategorySelect extends State<BoardCategorySelect> {
  // 現在選択されているカテゴリ名を保持
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 2.5,

        //カテゴリボタンの内容と色
        children: AppColors.categoryColors.entries.map((entry) {
          return categoryButton(entry.key, entry.value);
        }).toList(),
      ),
    );
  }

  Widget categoryButton(String label, Color color) {
    // 自分が選ばれているかどうか判定
    final bool isSelected = (selectedCategory == label);

    return GestureDetector(
      onTap: () {
        setState(() {
          //もう一度タップすると選択解除
          if (selectedCategory == label) {
            selectedCategory = ''; // 空にする（解除）
          } else {
            selectedCategory = label; // 選択
            widget.onChanged(selectedCategory);
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          border: Border.all(color: color, width: 2.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 25,
            color: isSelected ? Colors.white : AppColors.mainBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

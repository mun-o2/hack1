import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// 投稿リストの状態を管理するクラス
class PostListNotifier extends StateNotifier<List<Post>> {
  PostListNotifier() : super([]); // 最初は空リスト

  // 投稿を追加するメソッド
  void addPost(Post post) {
    // state（現在のリスト）に新しい投稿を加えて、新しいリストとして上書きする
    state = [...state, post];
  }
}

// 外部からこのクラスを操作するためのプロバイダー
final postListProvider = StateNotifierProvider<PostListNotifier, List<Post>>((
  ref,
) {
  return PostListNotifier();
});

//使用カラー管理
class AppColors {
  // メインのテーマカラーなど
  static const Color mainBrown = Color(0xFF6B4E3D);
  static const Color accentPink = Color(0xFFF4A5B1);
  static const Color backgroundBeige = Color(0xFFFEF8F1);

  static const Color accentYellow = Color(0xFFFAD28E);
  static const Color accentGreen = Color(0xFFB5C9A7);

  // カテゴリごとの色をMapで一括管理
  //かわいい
  static const Map<String, Color> categoryColors = {
    '震災': Color(0xFFF2B186),
    '戦争': Color(0xFFB5C9A7),
    '人生': Color(0xFF6B4E3D),
    '恋愛': Color(0xFFF4A5B1),
    '雑談': Color(0xFFFAD28E),
    'その他': Color(0xFF2A5AB0),
  };

  // 安全に色を取得するためのメソッド
  static Color getCategoryColor(String category) {
    return categoryColors[category] ?? Colors.grey;
  }
}

//掲示板の投稿１つ分
class Post {
  final String category;
  final String dateTime;
  final String content;

  Post({required this.category, required this.dateTime, required this.content});
}

//ホーム画面の各ボタン
class HomeMenuCard extends StatelessWidget {
  final String label;
  final String subLabel;
  final VoidCallback onTap;
  final IconData icon;
  final Color themeColor;

  const HomeMenuCard({
    super.key,
    required this.label,
    required this.subLabel,
    required this.onTap,
    required this.icon,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 115,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: themeColor, width: 3),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Row(
          children: [
            Icon(icon, size: 70, color: themeColor),

            const SizedBox(width: 40),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainBrown,
                    ),
                  ),
                  Text(
                    subLabel,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainBrown,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

//カテゴリの3×2表示・選択
class CategorySelect extends StatefulWidget {
  // 単一選択なら String、複数選択なら List<String> を扱う
  final Function(dynamic) onChanged;
  final bool isMultiSelect;
  final List<String> initialSelected;

  const CategorySelect({
    super.key,
    required this.onChanged,
    this.isMultiSelect = false,
    this.initialSelected = const [],
  });

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    selectedCategories = List.from(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 2.5,
      children: AppColors.categoryColors.entries.map((entry) {
        return categoryButton(entry.key, entry.value);
      }).toList(),
    );
  }

  Widget categoryButton(String label, Color color) {
    final bool isSelected = selectedCategories.contains(label);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.isMultiSelect) {
            // 複数選択モード
            if (isSelected) {
              selectedCategories.remove(label);
            } else {
              selectedCategories.add(label);
            }
            widget.onChanged(selectedCategories); // リストを返す
          } else {
            // 単一選択モード
            if (isSelected) {
              selectedCategories.clear();
              widget.onChanged(''); // 空文字を返す
            } else {
              selectedCategories = [label];
              widget.onChanged(label); // 文字列を返す
            }
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

class AppAssets {
  //芝生画像
  static const String glass = 'assets/images/glass.png';
}

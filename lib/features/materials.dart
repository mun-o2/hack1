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
  static const Color backgroundBeige = Color(0xFFFEF8F1);

  //見やすい
  static const Color contrastPink = Color(0xFFA51228);
  static const Color contrastYellow = Color(0xFF8E4210);
  static const Color contrastGreen = Color(0xFF4B5F3A);
  static const Map<String, Color> contrastCategoryColors = {
    '震災': Color(0xFF55508B),
    '戦争': Color(0xFF4B5F3A),
    '人生': Color(0xFF6B4E3D),
    '恋愛': Color(0xFFA51228),
    '雑談': Color(0xFFFAD28E),
    'その他': Color(0xFF36064C),
  };

  //かわいい
  static const Color pastelPink = Color(0xFFF4A5B1);
  static const Color pastelYellow = Color(0xFFFAD28E);
  static const Color pastelGreen = Color(0xFFB5C9A7);
  static const Map<String, Color> pastelCategoryColors = {
    '震災': Color(0xFFF2B186),
    '戦争': Color(0xFFB5C9A7),
    '人生': Color(0xFF6B4E3D),
    '恋愛': Color(0xFFF4A5B1),
    '雑談': Color(0xFFFAD28E),
    'その他': Color(0xFF2A5AB0),
  };

  static Color getCategoryColor(String category, Map<String, Color> colorSet) {
    // 指定された colorSet (contrast か pastel) から色を探す
    return colorSet[category] ?? Colors.grey;
  }
}

// trueなら「見やすい」、falseなら「かわいい」
final isHighContrastProvider = StateProvider<bool>((ref) => false);

// 現在のカラーセットを返すプロバイダー
final colorThemeProvider = Provider((ref) {
  final isHighContrast = ref.watch(isHighContrastProvider);

  return {
    'categories': isHighContrast
        ? AppColors.contrastCategoryColors
        : AppColors.pastelCategoryColors,
    'pink': isHighContrast ? AppColors.contrastPink : AppColors.pastelPink,
    'yellow': isHighContrast
        ? AppColors.contrastYellow
        : AppColors.pastelYellow,
    'green': isHighContrast ? AppColors.contrastGreen : AppColors.pastelGreen,
  };
});

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
        padding: const EdgeInsets.fromLTRB(36, 0, 20, 0),
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
  final Map<String, Color> categoryColors;

  const CategorySelect({
    super.key,
    required this.onChanged,
    required this.categoryColors,
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
      children: widget.categoryColors.entries.map((entry) {
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
            fontSize: 20,
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

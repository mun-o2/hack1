import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hack1/app/user_service.dart';

//ロール（若者or高齢者）を保持するプロバイダー
final roleProvider = StateProvider<String>(
  (ref) => 'student',
); //今は一旦若者をデフォルトにしてます

//-----------------------------------------------------------------
//現在ログイン中のユーザー情報（今回は仮で固定）
class AppUser {
  final String userId;
  final String userName;
  final String role;

  AppUser({required this.userId, required this.userName, required this.role});
}

final currentUserProvider = FutureProvider<AppUser>((ref) async {
  final userId = await UserService.getUserId();
  final role = await UserService.getRole();

  if (userId == null || role == null) {
    throw Exception('ユーザ情報がありません');
  }

  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .get();

  final data = doc.data();

  if (data == null) {
    throw Exception('ユーザデータがありません');
  }

  return AppUser(userId: userId, userName: data['name'] ?? '', role: role);
});

//-----------------------------------------------------------------
//掲示板投稿のデータモデル
class Post {
  final String id;
  final String category;
  final String dateTime;
  final String content;
  final DateTime createdAt;
  final String userId; //投稿者のユーザーID
  final String userName; //投稿者の名前
  final String targetRole; //投稿の対象（"student" または "senior"）

  Post({
    required this.id,
    required this.category,
    required this.dateTime,
    required this.content,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.targetRole,
  });
}

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

//-----------------------------------------------------------------
//firebaseからのデータ取得（掲示板）
final postsStreamProvider = StreamProvider<List<Post>>((ref) {
  return FirebaseFirestore.instance
      .collection('posts')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();

          return Post(
            id: doc.id,
            category: data['category'] ?? '',
            dateTime: data['dateTime'] ?? '',
            content: data['content'] ?? data['description'] ?? '',
            createdAt: (data['createdAt'] as Timestamp).toDate(),
            userId: data['userId'] ?? '',
            userName: data['userName'] ?? '名無し',
            targetRole: data['targetRole'] ?? '',
          );
        }).toList();
      });
});

//-----------------------------------------------------------------
//外部からこのクラスを操作するためのプロバイダー
final memoryListProvider = StreamProvider<List<Memory>>((ref) {
  return FirebaseFirestore.instance
      .collection('memories')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Memory.fromFirestore(doc);
        }).toList();
      });
});

//思い出のデータモデル(firestoreからに変更済み)
class Memory {
  final String id;
  final String userId;
  final String role;
  final String postId;
  final String message;

  final String studentId;
  final String studentName;
  final String seniorId;
  final String seniorName;

  final String category;
  final DateTime? createdAt;

  Memory({
    required this.id,
    required this.userId,
    required this.role,
    required this.postId,
    required this.message,

    required this.studentId,
    required this.studentName,
    required this.seniorId,
    required this.seniorName,

    required this.category,
    required this.createdAt,
  });

  factory Memory.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Memory(
      id: doc.id,
      userId: data['userId'] ?? '',
      role: data['role'] ?? '',
      postId: data['postId'] ?? '',
      message: data['message'] ?? '',
      studentId: data['studentId'] ?? '',
      studentName: data['studentName'] ?? '',
      seniorId: data['seniorId'] ?? '',
      seniorName: data['seniorName'] ?? '',
      category: data['category'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  //表示する相手の名前
  String get partnerName {
    if (role == 'student') {
      return seniorName;
    } else {
      return studentName;
    }
  }

  //仮アイコン：相手の役割で固定する
  // TODO:ユーザによって変更
  String get icon {
    if (role == 'student') {
      return 'assets/icons/blue-boy.png';
    } else {
      return 'assets/icons/pink-girl.png';
    }
  }

  // 仮：思い出を保存した日時を表示
  // TODO: スタート時間と終了時間をcallsからとってくる？
  String get dateTime {
    if (createdAt == null) {
      return '';
    }

    final month = createdAt!.month;
    final day = createdAt!.day;
    final hour = createdAt!.hour;
    final minute = createdAt!.minute.toString().padLeft(2, '0');

    return '$month/$day $hour:$minute';
  }
}

//-----------------------------------------------------------------
// アイコンの背景色を管理するStateProvider。初期値はパステルピンク
final iconBgColorProvider = StateProvider<Color>((ref) {
  return Colors.pink[100]!; // 初期の色
});

//-----------------------------------------------------------------
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
final isHighContrastProvider = StateProvider<bool>((ref) => true);

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

//-----------------------------------------------------------------
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

//-----------------------------------------------------------------
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

//-----------------------------------------------------------------
//カテゴリフィルター（掲示板、思い出）
class CategoryFilter extends StatelessWidget {
  final String? selectedCategory;
  final Function(String?) onCategorySelected;
  final Map<String, Color> themeColors;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.themeColors,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
      child: Row(
        children: themeColors.keys.map((category) {
          final Color themeColor = AppColors.getCategoryColor(
            category,
            themeColors,
          );
          final bool isSelected = selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: OutlinedButton(
              onPressed: () {
                // すでに選択中なら解除(null)、そうでなければ選択(category)
                onCategorySelected(isSelected ? null : category);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected ? themeColor : Colors.white,
                foregroundColor: isSelected
                    ? Colors.white
                    : AppColors.mainBrown,
                side: BorderSide(color: themeColor, width: 2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              child: Text(
                category,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

//-----------------------------------------------------------------
//左上の戻るボタン
Widget commonBackButton(BuildContext context, {VoidCallback? onPressed}) {
  return IconButton(
    icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.mainBrown),
    onPressed: onPressed ?? () => Navigator.of(context).pop(),
  );
}

import 'package:flutter/material.dart';
import 'package:hack1/features/materials.dart';

// データモデル
class Memory {
  final String partnerName;
  final String category;
  final String dateTime;

  Memory({
    required this.partnerName,
    required this.category,
    required this.dateTime,
  });
}

// ダミーデータ
final List<Memory> dummyMemories = [
  Memory(partnerName: 'はるかさん', category: '震災', dateTime: '4/28 17:00~17:30'),
  Memory(partnerName: 'さとうさん', category: '戦争', dateTime: '4/25 17:00~17:30'),
  Memory(partnerName: 'すずきさん', category: '雑談', dateTime: '4/20 17:00~17:30'),
  Memory(partnerName: 'たなかさん', category: '人生', dateTime: '4/18 17:00~17:30'),
];

class StudentMemoryScreen extends StatefulWidget {
  const StudentMemoryScreen({super.key});

  @override
  State<StudentMemoryScreen> createState() => _StudentMemoryScreenState();
}

class _StudentMemoryScreenState extends State<StudentMemoryScreen> {
  // 掲示板と同じく、選択中のカテゴリを管理（最初はnull＝すべて表示、または特定のカテゴリ）
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final categoryColors = AppColors.pastelCategoryColors;

    // フィルタリングされたリスト
    final filteredMemories = selectedCategory == null
        ? dummyMemories
        : dummyMemories.where((m) => m.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '思い出',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.mainBrown,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundBeige,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: AppColors.backgroundBeige,
      body: Column(
        children: [
          // --- カテゴリフィルター（掲示板と全く同じ構造） ---
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
            child: Row(
              children: categoryColors.keys.map((category) {
                return _buildCategoryButton(category, categoryColors);
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),

          // --- 思い出リスト ---
          Expanded(
            child: ListView.builder(
              itemCount: filteredMemories.length,
              itemBuilder: (context, index) {
                final memory = filteredMemories[index];
                return _memoryCard(
                  memory.partnerName,
                  memory.category,
                  memory.dateTime,
                  categoryColors,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // カテゴリボタン（掲示板のコードをそのまま採用）
  Widget _buildCategoryButton(String category, Map<String, Color> colorSet) {
    final Color themeColor = AppColors.getCategoryColor(category, colorSet);
    final bool isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedCategory = isSelected ? null : category;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? themeColor : Colors.white,
          foregroundColor: isSelected ? Colors.white : AppColors.mainBrown,
          side: BorderSide(color: themeColor, width: 2.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        ),
        child: Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  // 思い出カード（掲示板のスタイルをベースに、中身を組み替え）
  Widget _memoryCard(
    String partnerName,
    String category,
    String dateTime,
    Map<String, Color> colorSet,
  ) {
    final Color themeColor = AppColors.getCategoryColor(category, colorSet);

    return Container(
      width: 340,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mainBrown, width: 2),
      ),
      child: Column(
        children: [
          Text(
            '$partnerNameとお話',
            style: const TextStyle(
              fontSize: 22,
              color: AppColors.mainBrown,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(width: 40),

              Text(
                dateTime,
                style: const TextStyle(
                  color: AppColors.mainBrown,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

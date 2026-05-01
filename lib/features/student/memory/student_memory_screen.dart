import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hack1/features/materials.dart';

class StudentMemoryScreen extends ConsumerStatefulWidget {
  const StudentMemoryScreen({super.key});

  @override
  ConsumerState<StudentMemoryScreen> createState() =>
      _StudentMemoryScreenState();
}

class _StudentMemoryScreenState extends ConsumerState<StudentMemoryScreen> {
  // 掲示板と同じく、選択中のカテゴリを管理（最初はnull＝すべて表示、または特定のカテゴリ）
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final memories = ref.watch(memoryListProvider);
    final categoryColors = AppColors.pastelCategoryColors;

    final filteredMemories = selectedCategory == null
        ? memories
        : memories.where((m) => m.category == selectedCategory).toList();

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
          // カテゴリフィルター呼び出し
          CategoryFilter(
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
            themeColors: AppColors.pastelCategoryColors,
          ),
          const SizedBox(height: 10),

          // 思い出リスト
          Expanded(
            child: ListView.builder(
              itemCount: filteredMemories.length, // Providerからのデータ数
              itemBuilder: (context, index) {
                final memory = filteredMemories[index];

                return _memoryCard(
                  memory.partnerName,
                  memory.category,
                  memory.dateTime,
                  memory.icon,
                  categoryColors,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 思い出カード
  Widget _memoryCard(
    String partnerName,
    String category,
    String dateTime,
    String icon,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //アイコン
              Container(
                width: 59,
                height: 59,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundBeige,
                  image: (icon.isNotEmpty)
                      ? DecorationImage(
                          image: AssetImage(icon),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                // 画像がない時に表示するデフォルトのアイコン
                child: (icon.isEmpty)
                    ? const Icon(
                        Icons.person,
                        color: AppColors.mainBrown,
                        size: 30,
                      )
                    : null,
              ),

              const SizedBox(width: 26),

              Text(
                '$partnerNameとお話',
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.mainBrown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 4,
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

              const SizedBox(width: 37),

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

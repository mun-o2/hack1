import 'package:flutter/material.dart';
import 'package:hack1/features/materials.dart';

class StudentBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const StudentBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const Color activeColor = AppColors.pastelPink;
  static const Color selectedBgColor = Color(0xFFF3EEE9);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: SizedBox(
          height: 68,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                _NavItem(
                  index: 0,
                  selectedIndex: selectedIndex,
                  onTap: onTap,
                  icon: Icons.home_outlined,
                  label: 'ホーム',
                ),
                _NavItem(
                  index: 1,
                  selectedIndex: selectedIndex,
                  onTap: onTap,
                  icon: Icons.article_outlined,
                  label: '掲示板',
                ),
                _NavItem(
                  index: 2,
                  selectedIndex: selectedIndex,
                  onTap: onTap,
                  icon: Icons.grid_view_outlined,
                  label: '思い出',
                ),
                _NavItem(
                  index: 3,
                  selectedIndex: selectedIndex,
                  onTap: onTap,
                  icon: Icons.manage_accounts_outlined,
                  label: '設定',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final IconData icon;
  final String label;

  const _NavItem({
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? StudentBottomNavBar.selectedBgColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? StudentBottomNavBar.activeColor
                    : Colors.grey,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? StudentBottomNavBar.activeColor
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

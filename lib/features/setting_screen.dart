import 'package:flutter/material.dart';
import 'package:hack1/features/materials.dart';

class SettingScreen extends StatefulWidget {
  final Widget? additionalSettingContent;
  //学生なら聞きたいジャンル設定、高齢者なら話せるジャンル設定と色変更が含まれる

  const SettingScreen({super.key, this.additionalSettingContent});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isAccountView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      appBar: AppBar(
        title: Text(
          _isAccountView ? 'アカウント' : '設定',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.mainBrown,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _isAccountView
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.mainBrown),
                onPressed: () => setState(() => _isAccountView = false),
              )
            : null,
      ),
      body: _isAccountView ? _accountSetting() : settingMenuList(),
    );
  }

  //設定（共通）
  Widget settingMenuList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          const Text(
            '個人情報',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.mainBrown,
            ),
          ),
          const SizedBox(height: 12),
          SettingButton(
            label: 'アカウント',
            onTap: () => setState(() => _isAccountView = true),
          ),
          const SizedBox(height: 32),

          const Text(
            'アプリ情報',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.mainBrown,
            ),
          ),
          const SizedBox(height: 12),
          SettingButton(label: 'プライバシーポリシー', onTap: () => print('プライバシーポリシーへ')),
          const SizedBox(height: 16),
          SettingButton(label: '利用規約', onTap: () => print('利用規約へ')),
          const SizedBox(height: 16),
          SettingButton(label: 'お問い合わせ', onTap: () => print('お問い合わせへ')),
        ],
      ),
    );
  }

  // アカウント（共通項目 + 追加項目）
  Widget _accountSetting() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // テキストを左寄せに
        children: [
          const SizedBox(height: 20),

          //名前
          _buildSectionTitle('呼ばれたい名前'),
          const SizedBox(height: 8),
          SettingButton(
            label: 'はるかちゃん', // ここは後に変数にする
            onTap: () => print('名前変更ダイアログへ'),
          ),

          const SizedBox(height: 24),

          //生年月日
          _buildSectionTitle('生年月日'),
          const SizedBox(height: 8),
          SettingButton(
            label: '2004年6月1日', // ここも後に変数にする
            onTap: () => print('日付選択ダイアログへ'),
          ),

          const SizedBox(height: 24),

          //学生か高齢者かで入れ替わる項目
          if (widget.additionalSettingContent != null)
            widget.additionalSettingContent!,
        ],
      ),
    );
  }

  // --- セクションタイトルの共通パーツ ---
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.mainBrown,
      ),
    );
  }
}

// 設定画面専用の横長ボタン
class SettingButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SettingButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF625146).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

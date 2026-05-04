import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hack1/app/base_background.dart';
import 'package:hack1/features/materials.dart';

class SettingScreen extends ConsumerStatefulWidget {
  final Widget? additionalSettingContent;
  //学生なら聞きたいジャンル設定、高齢者なら話せるジャンル設定と色変更が含まれる

  const SettingScreen({super.key, this.additionalSettingContent});
  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  bool _isAccountView = false;

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(roleProvider);
    final bool isStudent = (role == 'student');

    return BaseBackground(
      title: _isAccountView ? 'アカウント' : '設定',
      leading: () {
        //戻るボタンの有無判定
        // 若者かつ設定画面なら、戻るボタン無
        if (isStudent && !_isAccountView) {
          return null;
        }
        // それ以外（高齢者すべて、または若者のアカウント画面）は戻るボタン有
        return commonBackButton(
          context,
          onPressed: _isAccountView
              ? () =>
                    setState(() => _isAccountView = false) // アカウントなら設定に戻る
              : null, // 高齢者の設定トップならホームに戻る
        );
      }(),
      child: _isAccountView ? _accountSetting() : settingMenuList(),
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
    //現在のアイコン背景色
    final currentIconColor = ref.watch(iconBgColorProvider);
    final user = ref.watch(currentUserProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // テキストを左寄せに
        children: [
          const SizedBox(height: 10),
          //ユーザアイコン
          Center(
            child: SizedBox(
              width: 125,
              height: 125,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // アイコン
                  Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color: currentIconColor,
                      image: const DecorationImage(
                        image: AssetImage('assets/icons/girl.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/girl.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error, color: Colors.red),
                              Text(
                                error.toString(), //ファイルが見つからない等エラー確認用
                                style: const TextStyle(fontSize: 8),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -20,
                    child: GestureDetector(
                      onTap: () => _showColorPicker(context), // 背景色選択を呼ぶ
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: AppColors.mainBrown,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          //名前
          _buildSectionTitle('呼ばれたい名前'),
          const SizedBox(height: 8),
          SettingButton(
            label: user.userName, // 後で変数にする
            onTap: () => print('名前変更ダイアログへ'),
          ),

          const SizedBox(height: 24),

          //生年月日
          _buildSectionTitle('生年月日'),
          const SizedBox(height: 8),
          SettingButton(
            label: '2004年6月1日', // 後で変数にする
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

  //タイトルの共通パーツ
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

  //背景色リスト
  void _showColorPicker(BuildContext context) {
    final List<Color> bgColors = [
      Colors.pink[100]!,
      Colors.blue[100]!,
      Colors.green[100]!,
      Colors.orange[100]!,
      Colors.purple[100]!,
      Colors.yellow[100]!,
      Colors.teal[100]!,
      Colors.grey[300]!,
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundBeige,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '背景色をえらぶ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: bgColors.map((color) {
                  return GestureDetector(
                    onTap: () {
                      ref.read(iconBgColorProvider.notifier).state = color;
                      // ここで色を選択した時の処理
                      print('色を選択しました: $color');
                      Navigator.pop(context); // ポップアップを閉じる
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
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

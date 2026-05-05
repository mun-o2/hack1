# hack1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# features内構成メモ
## onboardingフォルダ
* role_select_screen.dart
## seniorフォルダ
* board
  * senior_board.dart
* home
  * senior_home.dart
* memory
  * semior_memory.dart
* setting
  * senior_setting.dart（設定>アカウントのカテゴリ選択、カラーテーマ）

## studentフォルダ
* board
  * board_writing_space.dart（↓投稿作成画面のテキストフィールド部分）
  * student_board_post.dart（掲示板投稿作成）
  * student_board_screen.dart（掲示板閲覧）
* home
  * student_home.dart
* memory
  * student_mmemory.dart
* setting
  * student_setting.dart（設定>アカウントのカテゴリ選択）
* main
  * widgets
    * nav_bar.dart
  * student_main_tab.dart
    
## settingフォルダ
* base_background.dart（背景、芝生画像、戻るボタン、上部のタイトルなど共通部分）
* setting_screen.dart（設定画面、設定>アカウントのアイコン、名前、生年月日）

## materials.dart
（使用カラー、ホーム画面の各ボタン、掲示板・思い出のカテゴリフィルター、戻るボタンのデザインなど共通化しているパーツをここにまとめています）

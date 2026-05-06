import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/app/user_service.dart';
import 'package:hack1/features/materials.dart';

class InitialSettingScreen extends StatefulWidget {
  final bool isSenior;

  const InitialSettingScreen({super.key, required this.isSenior});

  @override
  State<InitialSettingScreen> createState() => _InitialSettingScreenState();
}

class _InitialSettingScreenState extends State<InitialSettingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _birthController.dispose();
    _genreController.dispose();
    super.dispose();
  }

  String get _birthLabel => widget.isSenior ? '生まれた年' : '生年月日';
  String get _genreLabel => widget.isSenior ? '話せるジャンル' : '聞きたいジャンル';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 36),
              const Text(
                '初期設定',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.mainBrown,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 48),
              _buildLabel('呼ばれたい名前'),
              const SizedBox(height: 12),
              _buildTextField(_nameController, hintText: ''),
              const SizedBox(height: 24),
              _buildLabel(_birthLabel),
              const SizedBox(height: 12),
              _buildTextField(_birthController, hintText: ''),
              const SizedBox(height: 24),
              _buildLabel(_genreLabel),
              const SizedBox(height: 12),
              _buildTextField(_genreController, hintText: ''),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    final userId = await UserService.getUserId();
                    final role = await UserService.getRole();

                    print('userId: $userId');
                    print('role: $role');

                    if (userId == null || role == null) {
                      print('useridかroleがnullです');
                      return;
                    }
                    ;
                    //firestore処理
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .set({
                          'name': _nameController.text,
                          'birth': _birthController.text,
                          'genre': _genreController.text,
                          'role': role,
                          'createdAt': Timestamp.now(),
                        });

                    if (!context.mounted) return;

                    if (widget.isSenior) {
                      context.go('/senior');
                    } else {
                      context.go('/student');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF4A5B1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    'はじめる',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.mainBrown,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFE2E2E2),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: AppColors.mainBrown, fontSize: 18),
    );
  }
}

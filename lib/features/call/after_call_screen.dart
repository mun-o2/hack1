import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/app/user_service.dart';
import 'package:hack1/features/materials.dart';

class AfterCallMessageScreen extends ConsumerStatefulWidget {
  final String postId;

  const AfterCallMessageScreen({super.key, required this.postId});

  @override
  ConsumerState<AfterCallMessageScreen> createState() =>
      _AfterCallMessageScreenState();
}

class _AfterCallMessageScreenState
    extends ConsumerState<AfterCallMessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();

    if (message.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('メッセージを入力してください')));
      return;
    }

    setState(() {
      _isSending = true;
    });

    final userId = await UserService.getOrCreateUserId();
    final role = ref.read(roleProvider);

    // firestoreからデータ持ってくる
    final postDoc = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .get();

    final postData = postDoc.data();

    final studentId = postData?['userId'] ?? '';
    final studentName = postData?['userName'] ?? '';

    final callDoc = await FirebaseFirestore.instance
        .collection('calls')
        .doc(widget.postId)
        .get();

    final callData = callDoc.data();
    final participantIds = List<String>.from(callData?['participantIds'] ?? []);

    final seniorId = participantIds.firstWhere(
      (id) => id != studentId,
      orElse: () => '',
    );

    String seniorName = '';

    if (seniorId.isNotEmpty) {
      final seniorDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(seniorId)
          .get();

      seniorName = seniorDoc.data()?['name'] ?? '';
    }

    await FirebaseFirestore.instance.collection('memories').add({
      'postId': widget.postId,
      'userId': userId,
      'role': role,
      'message': message,

      'studentId': studentId,
      'studentName': studentName,
      'seniorId': seniorId,
      'seniorName': seniorName,

      'category': postData?['category'] ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    // メッセージ入力されたら
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('思い出に保存されました')));

    context.go(role == 'senior' ? '/senior/memory' : '/student/memory');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // キーボードが出てもボタンが上がらないように
      backgroundColor: AppColors.backgroundBeige,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              const Text(
                '通話を終了しました',
                style: TextStyle(
                  color: AppColors.mainBrown,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                '相手にひとことメッセージを送って、思い出に保存しましょう',
                style: TextStyle(
                  color: AppColors.mainBrown,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              TextField(
                controller: _messageController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: '今日はお話しできてよかったです。',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSending ? null : _sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainBrown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(28),
                    ),
                  ),
                  child: Text(_isSending ? '保存中...' : '思い出に保存する'),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

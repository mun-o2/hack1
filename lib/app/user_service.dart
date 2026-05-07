import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

// userのfirebaseへの保存、取得
// 端末でid登録
class UserService {
  static Future<String> getOrCreateUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString('userId');

    if (savedId != null) {
      return savedId;
    }

    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    await prefs.setString('userId', newId);
    return newId;
  }

  static const String _roleKey = "role";

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);

    final userId = await getOrCreateUserId();

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'role': role,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  //role ゲッター
  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  // ユーザidセッター
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  //userId ゲッター
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
}

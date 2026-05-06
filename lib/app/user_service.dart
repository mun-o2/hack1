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

  static Future<void> saveRole(String role) async {
    final userId = await getOrCreateUserId();

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'role': role,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}

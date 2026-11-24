import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/literary_item.dart';

class LiteraryRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Đảm bảo người dùng luôn có UID ẩn danh trên Firebase để đồng bộ
  Future<String> ensureUser() async {
    User? user = _auth.currentUser;
    if (user == null) {
      final credential = await _auth.signInAnonymously();
      user = credential.user;
    }
    return user!.uid;
  }

  // Lấy danh sách bài viết theo loại ('ca_dao', 'tuc_ngu', 'truyen_ngan')
  Stream<List<LiteraryItem>> streamItemsByType(String type) {
    return _db
        .collection('literary_items')
        .where('type', isEqualTo: type)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => LiteraryItem.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  // Lấy tập hợp ID các bài đã lưu yêu thích để tô đỏ icon trái tim
  Stream<Set<String>> streamFavoriteIds(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.id).toSet());
  }

  // Lấy danh sách bài yêu thích theo từng loại cho màn hình Yêu thích
  Stream<List<LiteraryItem>> streamFavoritesByType(String uid, String type) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .where('type', isEqualTo: type)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => LiteraryItem.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  // Thêm hoặc Xóa khỏi danh sách yêu thích trên Firebase
  Future<void> toggleFavorite(String uid, LiteraryItem item, bool isFav) async {
    final docRef = _db
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(item.id);

    if (isFav) {
      await docRef.delete();
    } else {
      await docRef.set(item.toMap());
    }
  }
}

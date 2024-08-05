import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagement {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserRole(String uid, String role) async {
    await _firestore.collection('users').doc(uid).set({'role': role});
  }

  Future<String?> getUserRole(String uid) async {
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(uid).get();
    return snapshot['role'];
  }
}

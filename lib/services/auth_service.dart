import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // বর্তমান লগইন করা ইউজার পাওয়া
  User? get currentUser => _auth.currentUser;

  // ১. সাইন-আপ (Sign Up) ও Firestore-এ ইউজার তথ্য সংরক্ষণ
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role, // 'donor', 'volunteer', 'admin'
  }) async {
    try {
      // Firebase Auth-এ ইউজার ক্রিয়েট
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Firestore-এ ইউজারের এক্সট্রা তথ্য (নাম, ফোন, রোল) সেভ করা
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'name': name,
          'email': email,
          'phone': phone,
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // ২. লগইন (Login)
  Future<UserCredential?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // ৩. ফায়ারবেস থেকে ইউজারের রোল নিয়ে আসা (Get User Role)
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['role'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // ৪. ফায়ারবেস থেকে ইউজারের নাম নিয়ে আসা (Get User Name)
  Future<String?> getUserName(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['name'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // ৫. লগআউট (Sign Out)
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
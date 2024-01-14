import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training/core/common/model/user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// signUp
  Future<UserModel?> signUp(
      String email, String password, String fullname) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final Map<String, dynamic> userData = {
        'name': fullname.trim(),
        'email': email.trim(),
        'password': password.trim(),
      };

      await firestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .set(userData);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  /// Login
  Future<UserModel?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  ///signOut
  Future<void> signOut() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await _firebaseAuth.signOut();
    }
  }
}

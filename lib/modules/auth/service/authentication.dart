import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    } catch (e) {
      rethrow;
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
    } catch (e) {
      rethrow;
    }
    return null;
  }

  /// Login
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final Map<String, dynamic> userData = {
        'name': userCredential.user?.displayName,
        'email': userCredential.user?.email,
      };

      await firestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .set(userData);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  ///signOut
  Future<void> signOut() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await _firebaseAuth.signOut();
    }
  }
}

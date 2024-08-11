import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/feature/authentication/model/user_model.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _collection = FirebaseFirestore.instance.collection("users");

  Future<UserModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      DocumentSnapshot userDoc =
          await _collection.doc(userCredential.user!.uid).get();

      return UserModel(
          id: userCredential.user!.uid, name: userDoc["name"], email: email);
    } on FirebaseAuthException catch (error) {
      print("Login Error: ${error.toString()}");
      return null;
    }
  }

  Future<UserModel?> register(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _collection.doc(userCredential.user!.uid).set({
        "name": name,
        "email": email,
      });

      return UserModel(id: userCredential.user!.uid, name: name, email: email);
    } on FirebaseAuthException catch (error) {
      print("Register Error: ${error.toString()}");
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await _collection.doc(user.uid).get();
      return UserModel(id: user.uid, name: userDoc["name"], email: user.email);
    }
    return null;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/feature/authentication/model/user_model.dart';
import 'package:todo_app/product/utility/exception/auth_exception.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _collection = FirebaseFirestore.instance.collection("users");
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      DocumentSnapshot userDoc =
          await _collection.doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        throw AuthException(message: "User doc not exist");
      }

      return UserModel(
          id: userCredential.user!.uid, name: userDoc["name"], email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: "Login Error: ${e.toString()}");
    } catch (e) {
      throw AuthException(message: "Unexpected Error: ${e.toString()}");
    }
  }

  Future<UserModel> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _collection.doc(userCredential.user!.uid).set({
        "name": name,
        "email": email,
      });

      return UserModel(id: userCredential.user!.uid, name: name, email: email);
    } on FirebaseAuthException catch (error) {
      throw AuthException(message: "Register Error: ${error.toString()}");
    } catch (e) {
      throw AuthException(message: "Unexpected Error: ${e.toString()}");
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } on FirebaseAuthException catch (error) {
      throw AuthException(message: "Log out error: ${error.toString()}");
    } catch (e) {
      throw AuthException(message: "Unexpected Error: ${e.toString()}");
    }
  }

  Future<void> updateUserName(String newName) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await user.updateDisplayName(newName);

        await _firestore
            .collection("users")
            .doc(user.uid)
            .update({"name": newName});

      } catch (error) {
        throw AuthException(message: "Update User Name Error: $error");
      }
    } else {
      throw AuthException(message: "No user is currently signed in.");
    }
  }

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection("users").doc(user.uid).get();

        if (!userDoc.exists) {
          throw AuthException(message: "User doc not exist");
        }

        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        return UserModel(
          id: user.uid,
          name: userData['name'] ?? user.displayName ?? "",
          email: user.email ?? "",
        );
      } on FirebaseAuthException catch (error) {
        throw AuthException(message: error.toString());
      } catch (e) {
        throw AuthException(message: e.toString());
      }
    }
    return null;
  }


  Future<UserModel> signInWithGoogle() async {
    try {
      // Close current session
      await _googleSignIn.signOut();
      await _auth.signOut();

      // Start a new google sign-in
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw AuthException(message: "Google sign-in cancelled by user");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // Update or create user information in firestore
        await _firestore.collection("users").doc(user.uid).set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
        }, SetOptions(merge: true));

        return UserModel(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
      } else {
        throw AuthException(message: "Google sign in failed!");
      }
    } catch (error) {
      throw AuthException(message: "Google sign in error: ${error.toString()}");
    }
  }

  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      throw AuthException(message: "Password reset error: ${error.toString()}");
    }
  }
}

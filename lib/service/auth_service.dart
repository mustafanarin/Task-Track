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
        // Firebase Authentication'daki kullanıcı profilini güncelle
        await user.updateDisplayName(newName);

        // Firestore'daki kullanıcı belgesini güncelle
        await _firestore
            .collection("users")
            .doc(user.uid)
            .update({"name": newName});

        // Google hesabı ile giriş yapılmış olsa bile, yeniden giriş yapmaya zorlamıyoruz
        // Sadece yerel veritabanı ve Firebase'deki bilgileri güncelliyoruz
      } catch (error) {
        throw AuthException(message: "Update User Name Error: $error" );
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
          pendingEmail: userData['pendingEmail'],
        );
      } on FirebaseAuthException catch (error) {
        throw AuthException(message: error.toString());
      } catch (e) {
        throw AuthException(message: e.toString());
      }
    }
    return null;
  }

  Future<void> updateUserEmail(String newEmail) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        // Önce e-posta değişikliği için doğrulama e-postası gönder
        await user.verifyBeforeUpdateEmail(newEmail);

        // Firestore'daki kullanıcı belgesini güncelle
        // Not: Bu güncelleme, e-posta doğrulaması tamamlandıktan sonra yapılmalıdır.
        // Şu an için sadece bir işaretçi ekliyoruz.
        await _firestore.collection("users").doc(user.uid).update({
          "pendingEmail": newEmail,
        });

        // Burada bir listener ekleyebiliriz ki e-posta doğrulandığında Firestore'u güncelleyelim
        // Bu örnekte bunu yapmıyoruz, ama gerçek bir uygulamada bu önemli olabilir
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          throw Exception(
              'The email address is already in use by another account.');
        } else if (e.code == 'invalid-email') {
          throw Exception('The email address is invalid.');
        } else {
          throw Exception(
              'An error occurred while updating the email: ${e.message}');
        }
      } catch (e) {
        throw Exception('An unexpected error occurred: $e');
      }
    } else {
      throw Exception("No user is currently signed in.");
    }
  }

  Stream<UserModel> getUserStream(String userId) {
    return _collection.doc(userId).snapshots().map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      return UserModel(
        id: userId,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
      );
    });
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      // Mevcut oturumu kapat
      await _googleSignIn.signOut();
      await _auth.signOut();

      // Yeni bir Google Sign-In işlemi başlat
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw AuthException(message: "Google sign-in cancelled by user");
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // Firestore'da kullanıcı bilgilerini güncelle veya oluştur
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
}

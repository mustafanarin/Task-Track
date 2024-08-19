import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/feature/authentication/model/user_model.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _collection = FirebaseFirestore.instance.collection("users");
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      try {
        await _auth.signOut();
        await _googleSignIn.signOut();  
      } on FirebaseAuthException catch (error) {
        print("Sign Out Error: $error");
      }
    }

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
    try{
      
      DocumentSnapshot userDoc = await _collection.doc(user.uid).get();
      return UserModel(id: user.uid, name: userDoc["name"] ?? "", email: user.email ?? "");
    
    } on FirebaseAuthException catch (error) {
      print("Get Current User Error: $error");
    }
    }
    return null;
  }

   Future<void> updateUserName(String newName) async {
    final user = _auth.currentUser;
    try{
      if (user != null) {
      await _collection.doc(user.uid).update({"name": newName});
    }
    } on FirebaseAuthException catch (error) {
      print("Update User name Error: $error");
    }
    
  }

  Future<void> updateUserEmail(String newEmail) async {
    final user = _auth.currentUser;
    try{
      if (user != null) {

      await user.verifyBeforeUpdateEmail(newEmail);
      if(user.email == newEmail){
        await _collection.doc(user.uid).update({"email": newEmail});
      }
      
    }
    }on FirebaseAuthException catch (error) {
      print("Update User email Error: $error");
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

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // Firestore'da kullanıcı bilgilerini güncelle veya oluştur
        await _collection.doc(user.uid).set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
        }, SetOptions(merge: true));

        return UserModel(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
      }
    } catch (error) {
      print("Google Sign In Error: $error");
    }
    return null;
  }
}

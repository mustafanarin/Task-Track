// Auth Service Provider
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/service/auth_service.dart';

import '../../../product/utility/exception/auth_exception.dart';
import '../model/user_model.dart';
import '../state/user_state.dart';

// Auht State Provider
final loginProvider = AutoDisposeNotifierProvider<LoginProvider, UserState>(
    () => LoginProvider.new(AuthService()));

// State Notifier
class LoginProvider extends AutoDisposeNotifier<UserState> {
  final AuthService _authService;
  LoginProvider(this._authService);

  @override
  UserState build() {
    return UserState(user: const UserModel(), isLoading: false);
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authService.login(email, password);
      state = state.copyWith(user: user);

    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
      throw AuthException(message: e.toString());

    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
      throw AuthException(message: e.toString());

    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authService.signInWithGoogle();
      state = state.copyWith(user: user);

    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false);
      print("Google Sign In Error: ${e.message}");
      throw AuthException(message: e.toString());

    } catch (e) {
      state = state.copyWith(isLoading: false);
      print("Unexpected error during Google Sign In: $e");
      throw AuthException(message: e.toString());

    }
  }

  Future<void> sendPasswordResetLink(String email) async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService.sendPasswordResetLink(email);
      state = state.copyWith(isLoading: false);

    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
      throw AuthException(message: e.toString());
      
    }
  }
}

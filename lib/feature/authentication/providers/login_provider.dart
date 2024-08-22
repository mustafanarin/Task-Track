// Auth Service Provider
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/service/auth_service.dart';

import '../../../product/utility/exception/auth_exception.dart';
import '../model/user_model.dart';
import '../state/user_state.dart';

final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Auht State Provider
final loginProvider = StateNotifierProvider<LoginProvider, UserState>((ref) {
  final authService = ref.watch(authenticationProvider);
  return LoginProvider(authService);
});

// State Notifier
class LoginProvider extends StateNotifier<UserState> {
  final AuthService _authService;
  LoginProvider(this._authService)
      : super(UserState(user: const UserModel(), isLoading: false));

  Future<void> _initializeUser() async {
    state = state.copyWith(isLoading: true);
    try {
      final UserModel? currentUser = await _authService.getCurrentUser();

      if (currentUser != null) {
        state = state.copyWith(user: currentUser, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Error: ${e.toString()}");
      state = state.copyWith(isLoading: false);
    } catch (e) {
      print("Error: ${e.toString()}");
      state = state.copyWith(isLoading: false);
    }
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
}

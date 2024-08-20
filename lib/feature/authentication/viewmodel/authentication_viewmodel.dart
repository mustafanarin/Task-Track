import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app/feature/authentication/model/user_model.dart';

import 'package:todo_app/service/auth_service.dart';

// Auth Service Provider
final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Auht State Provider
final authProvider = StateNotifierProvider<AuthNotifier, UserState>((ref) {
  final authService = ref.watch(authenticationProvider);
  return AuthNotifier(authService);
});

class UserState {
  final UserModel user;
  final bool isLoading;

  UserState({required this.user, required this.isLoading});

  UserState copyWith({
    UserModel? user,
    bool? isLoading,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// State Notifier
class AuthNotifier extends StateNotifier<UserState> {
  final AuthService _authService;
  AuthNotifier(this._authService)
      : super(UserState(user: const UserModel(), isLoading: false)) {
    _initializeUser();
  }

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
      state = state.copyWith(user: user, isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
    }
  }

  Future<void> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authService.register(name, email, password);
      state = state.copyWith(user: user, isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService.logout();
      state = state.copyWith(isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authService.signInWithGoogle();
      state = state.copyWith(user: user, isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);
      print("Firebase Auth Error: ${e.message}");
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print("Unexpected error during Google Sign In: $e");
    }
  }
}

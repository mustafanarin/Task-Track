import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/authentication/model/user_model.dart';
import 'package:todo_app/service/auth_service.dart';

final profileViewModelProvider = StateNotifierProvider<ProfileViewModel, AsyncValue<UserModel?>>((ref) {
  return ProfileViewModel(AuthService());
});

class ProfileViewModel extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthService _authService;
  late final StreamSubscription<User?> _authStateSubscription;

  ProfileViewModel(this._authService) : super(const AsyncValue.loading()) {
    _authStateSubscription = _authService.authStateChanges.listen((user) {
      if (user != null) {
        getCurrentUser();
      } else {
        state = const AsyncValue.data(null);
      }
    });
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  Future<void> updateUserName(String newName) async {
    state = const AsyncValue.loading();
    try {
      await _authService.updateUserName(newName);
      await getCurrentUser(); 
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _authService.getCurrentUser();
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateUserEmail(String newEmail) async {
    state = const AsyncValue.loading();
    try {
      await _authService.updateUserEmail(newEmail);
      await getCurrentUser(); 
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow; 
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = const AsyncValue.data(null);
  }
}
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/authentication/model/user_model.dart';
import 'package:todo_app/service/auth_service.dart';

final profileViewModelProvider = StateNotifierProvider<ProfileViewModel, AsyncValue<UserModel?>>((ref) {
  return ProfileViewModel(AuthService());
});

class ProfileViewModel extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthService _authService;

  ProfileViewModel(this._authService) : super(const AsyncValue.loading()) {
    getCurrentUser();
  }
  
  Future<void> getCurrentUser() async {
    state = const AsyncValue.loading();
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        state = AsyncValue.data(user);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
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

  Future<void> updateUserEmail(String newEmail) async {
    state = const AsyncValue.loading();
    try {
      await _authService.updateUserEmail(newEmail);
      await getCurrentUser();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = const AsyncValue.data(null);
  }
}
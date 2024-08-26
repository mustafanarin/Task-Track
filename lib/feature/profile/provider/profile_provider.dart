import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/authentication/model/user_model.dart';
import 'package:todo_app/feature/profile/state/profile_state.dart';
import 'package:todo_app/service/auth_service.dart';
import 'package:todo_app/product/utility/exception/auth_exception.dart';

final profileProvider =
    AutoDisposeNotifierProvider<ProfileProvider, ProfileState>(
        () => ProfileProvider.new(AuthService()));

class ProfileProvider extends AutoDisposeNotifier<ProfileState> {
  final AuthService _authService;

  ProfileProvider(this._authService);
  @override
  ProfileState build() {
    _init();
    return ProfileState(user: const UserModel(), isLoading: true);
  }

  Future<void> _init() async {
    await _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      final UserModel? currentUser = await _authService.getCurrentUser();
      if (currentUser != null) {
        state = state.copyWith(user: currentUser, isLoading: false);
      } else {
        state = state.copyWith(user: const UserModel(), isLoading: false);
      }
    } catch (e) {
      print("Initialize user error: ${e.toString()}");
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateUserName(String newName) async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService.updateUserName(newName);
      final updatedUser = state.user.copyWith(name: newName);
      state = state.copyWith(user: updatedUser, isLoading: false);
    } catch (e) {
      print("Update user name error: ${e.toString()}");
      state = state.copyWith(isLoading: false);
      throw AuthException(message: e.toString());
    }
  }

  Future<void> updateUserEmail(String newEmail) async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService.updateUserEmail(newEmail);
      final updatedUser = state.user.copyWith(email: newEmail);
      state = state.copyWith(user: updatedUser, isLoading: false);
    } catch (e) {
      print("Update user email error: ${e.toString()}");
      state = state.copyWith(isLoading: false);
      throw AuthException(message: e.toString());
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService.logout();
      state = ProfileState(user: const UserModel(), isLoading: false);
    } catch (e) {
      print("Logout error: ${e.toString()}");
      state = state.copyWith(isLoading: false);
      throw AuthException(message: e.toString());
    }
  }
}

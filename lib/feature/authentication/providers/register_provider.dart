
// Auth Service Provider
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/authentication/state/user_state.dart';

import '../../../service/auth_service.dart';
import '../model/user_model.dart';

final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Auht State Provider
final registerProvider = StateNotifierProvider<RegisterProvider, UserState>((ref) {
  final authService = ref.watch(authenticationProvider);
  return RegisterProvider(authService);
});


// State Notifier
class RegisterProvider extends StateNotifier<UserState> {
  final AuthService _authService;
  RegisterProvider(this._authService)
      : super(UserState(user: const UserModel(), isLoading: false));


  Future<void> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authService.register(name, email, password);
      state = state.copyWith(user: user);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e.toString());
    }
  }

}

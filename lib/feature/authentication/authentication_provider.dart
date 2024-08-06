import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/product/model/user_model.dart';
import 'package:todo_app/service/auth_service.dart';

final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authProvider = StateNotifierProvider<AuthNotifier, UserModel?>((ref) {
  final authService = ref.watch(authenticationProvider);
  return AuthNotifier(authService);
});

class AuthNotifier extends StateNotifier<UserModel?> {
  final AuthService _authService;
  AuthNotifier(this._authService) : super(null) {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      state = await _authService.getCurrentUser();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        state = user;
        return true;
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final user = await _authService.register(name, email, password);
      if (user != null) {
        state = user;
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      state = null;
    } catch (e) {
      print(e.toString());
    }
  }
}

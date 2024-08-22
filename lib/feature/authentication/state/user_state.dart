import 'package:todo_app/feature/authentication/model/user_model.dart';

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
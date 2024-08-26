
import '../../authentication/model/user_model.dart';

class ProfileState {
  final UserModel user;
  final bool isLoading;

  ProfileState({required this.user, required this.isLoading});


  ProfileState copyWith({
    UserModel? user,
    bool? isLoading,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

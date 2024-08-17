enum ProfileEditEnum {
  name,
  email
}

extension ProfileEditEnumExtension on ProfileEditEnum {
  bool get isName => this == ProfileEditEnum.name;
  bool get isEmail => this == ProfileEditEnum.email;
}
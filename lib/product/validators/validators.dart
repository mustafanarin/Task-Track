class Validators {
  static const String _nameNotEmpty = 'Name and surname cannot be left blank';
  static const String _nameIsLetter =
      'Name and surname must consist of letters only';

  static const String _emailNotEmpty = 'Email cannot be left blank';
  static const String _emailIsValid = 'Please enter a valid email';

  static const String _passwordNotEmpty = 'Password cannot be left blank';
  static const String _passwordLeastSixCharecter =
      'Password must be at least 6 characters';

  static const String _passwordAgain = 'Please re-enter your password';
  static const String _passwordDontMatch = 'Passwords don\'t match';

  static const String _taskNameNotEmpty = 'Please enter a task name.';

  // name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return _nameNotEmpty;
    }
    //Checks that it consists of letters only, regex
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return _nameIsLetter;
    }
    return null;
  }

  // email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return _emailNotEmpty;
    }
    // Basit bir e-posta regex'i
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return _emailIsValid;
    }
    return null;
  }

  // password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return _passwordNotEmpty;
    }
    if (value.length < 6) {
      return _passwordLeastSixCharecter;
    }
    return null;
  }

  // confirm
  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return _passwordAgain;
    }
    if (value != password) {
      return _passwordDontMatch;
    }
    return null;
  }

  // Task name
  String? validateTaskNameNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return _taskNameNotEmpty;
    }
    return null;
  }
}

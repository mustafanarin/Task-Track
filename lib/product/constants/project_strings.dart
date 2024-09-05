import 'package:flutter/material.dart';

@immutable
class ProjectStrings {
  const ProjectStrings._();

  // Welcome Page
  static const String appName = "Task Track";
  static const String appName1 = "Task";
  static const String appName2 = "Track";
  static const String welcomeDescription =
      "Every successful day starts with a well-planned list. Manage your tasks and achieve your goals.";
  static const String loginButton = "Login";
  static const String registerButton = "Register";

  // Login Page
  static const String appBarSuptitle = "Login to continue using the app";
  static const String emailText = "Email";
  static const String tfEmailHint = "Enter your email";
  static const String passwordText = "Password";
  static const String tfPasswordHint = "Enter password";
  static const String forgatPasswordBtn = "Forgot password?";
  static const String divderOrText = "or";
  static const String loginWithGoogle = "Login using Google";
  static const String haventAccont = "Don't have an account?";
  static const String loginError = "Login failed, please try again.";
  static const String googleLoginError =
      "Google login failed, please try again.";
  static const String forgotPassword = "Forgot password";
  static const String tryAgainMessage =
      "An error occurred during Google login. Please try again.";

  // Forgot Password Page
  static const String buttonText = "Send email";

  // Register Page
  static const String supTitle = "Enter your personel information";
  static const String userName = "Username";
  static const String tfUserNameHint = "Enter your name";
  static const String confirmText = "Confirm Password";
  static const String tfConfirmHint = "Enter confirm password";
  static const String registerError = "Register failed, please try again.";

  // Home Page
  static const String newTaskCard = 'New Added';
  static const String continuesTaskCard = "Continues";
  static const String finishedTaskCard = "Finished";

  // Task Add Page
  static const String toastSuccessAddMessage = "Task added successfully!";
  static const String toastErrorAddMessage = "An error occurred:";
  static const String taskAddAppbarTitle = 'New Task';
  static const String tfhintTaskName = 'Task Name';
  static const String tfhintTaskDes = 'Description...';
  static const String dropdownImportance = 'Importance Score';
  static const String iconListTitle = 'Select Task Icon';
  static const String saveButtonText = "Save";

  // Task Detail Page
  static const String taskDetailAppbarTitle = "Task Detail";

  // Task Edit Page
  static const String toastSuccessUpdateMessage = "Task updated successfully!";
  static const String categoryNameNew = "New";
  static const String categoryNameContinue = "Continue";
  static const String categoryNameFinished = "Finished";
  static const String taskEditAppbarTitle = "Task Edit";
  static const String dropdownCategory = "Select status";

  // Task List Page
  static const String shortByName = 'Sort by name';
  static const String shortByImportance = 'Sort by importance';
  static const String delete = "Delete";

  // Profile
  static const String profileAppbar = "Profile";
  static const String userIsNull = "User not logged in";
  static const String logoutApp = "Log Out";
  static const String logOutQuestionText = "Are you sure you want to log out?";

  // Profile Edit
  static const String profileEditAppbar = "Name Edit";
  static const String enterName = "Enter your name";
  static const String enterEmail = "Enter your email";
  static const String toastSuccessUpdateNameMessage =
      "Name updated successfully!";
  static const String alertDialogVertificationQuestion =
      "We will send you a verification link. Do you still want to do it?";
  static const String toastUpdateEmail = "Please check your email!";
}

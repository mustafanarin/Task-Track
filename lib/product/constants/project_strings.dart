import 'package:flutter/material.dart';

@immutable
class ProjectStrings {
  const ProjectStrings._();

  static const String appName = "Task Track";
  static const String appName1 = "Task";
  static const String appName2 = "Track";

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Welcome Page
      'appName': "Task Track",
      'appName1': "Task",
      'appName2': "Track",
      'welcomeDescription':
          "Every successful day starts with a well-planned list. Manage your tasks and achieve your goals.",
      'loginButton': "Login",
      'registerButton': "Register",

      // Login Page
      'appBarSuptitle': "Login to continue using the app",
      'emailText': "Email",
      'tfEmailHint': "Enter your email",
      'passwordText': "Password",
      'tfPasswordHint': "Enter password",
      'forgatPasswordBtn': "Forgot password?",
      'divderOrText': "or",
      'loginWithGoogle': "Login using Google",
      'haventAccont': "Don't have an account?",
      'loginError': "Login failed, please try again.",
      'googleLoginError': "Google login failed, please try again.",
      'forgotPassword': "Forgot password",
      'tryAgainMessage':
          "An error occurred during Google login. Please try again.",

      // Forgot Password Page
      'buttonText': "Send email",
      'successfulMessage': "A password reset email has been sent to",
      'failedMessage': "Password reset email could not be sent:",

      // Register Page
      'supTitle': "Enter your personal information",
      'userName': "Username",
      'tfUserNameHint': "Enter your name",
      'confirmText': "Confirm Password",
      'tfConfirmHint': "Enter confirm password",
      'registerError': "Register failed, please try again.",

      // Home Page
      'newTaskCard': 'New Added',
      'continuesTaskCard': "Continues",
      'finishedTaskCard': "Finished",

      // Task Add Page
      'toastSuccessAddMessage': "Task added successfully!",
      'toastErrorAddMessage': "An error occurred:",
      'taskAddAppbarTitle': 'New Task',
      'tfhintTaskName': 'Task Name',
      'tfhintTaskDes': 'Description...',
      'dropdownImportance': 'Importance Score',
      'iconListTitle': 'Select Task Icon',
      'saveButtonText': "Save",

      // Task Detail Page
      'taskDetailAppbarTitle': "Task Detail",
      'categoryText': "Category:",

      // Task Edit Page
      'toastSuccessUpdateMessage': "Task updated successfully!",
      'categoryNameNew': "New",
      'categoryNameContinue': "Continue",
      'categoryNameFinished': "Finished",
      'taskEditAppbarTitle': "Task Edit",
      'dropdownCategory': "Select status",

      // Task List Page
      'shortByName': 'Sort by name',
      'shortByImportance': 'Sort by importance',
      'delete': "Delete",
      'taskDeleted': "Task deleted.",
      'noTask': "missions yet.",

      // Profile
      'profileAppbar': "Profile",
      'userIsNull': "User not logged in",
      'logoutApp': "Log Out",
      'logOutQuestionText': "Are you sure you want to log out?",
      'logOutNotificationTitle': "Session closed!",
      'logOutNotificationDescription': "We are sorry to see you go.",
      'appLanguage': "Application language: English",

      // Profile Edit
      'profileEditAppbar': "Name Edit",
      'enterName': "Enter your name",
      'enterEmail': "Enter your email",
      'toastSuccessUpdateNameMessage': "Name updated successfully!",
      'alertDialogVertificationQuestion':
          "We will send you a verification link. Do you still want to do it?",
      'toastErrorUpdateNameMessage': "An error occurred while updating the name:",
    },
    'tr': {
      // Karşılama Sayfası
      'appName': "Görev Takibi",
      'appName1': "Görev",
      'appName2': "Takibi",
      'welcomeDescription':
          "Her başarılı gün iyi planlanmış bir liste ile başlar. Görevlerinizi yönetin ve hedeflerinize ulaşın.",
      'loginButton': "Giriş Yap",
      'registerButton': "Kayıt Ol",

      // Giriş Sayfası
      'appBarSuptitle': "Devam etmek için giriş yapın",
      'emailText': "E-posta",
      'tfEmailHint': "E-posta adresinizi girin",
      'passwordText': "Şifre",
      'tfPasswordHint': "Şifrenizi girin",
      'forgatPasswordBtn': "Şifremi unuttum?",
      'divderOrText': "veya",
      'loginWithGoogle': "Google ile giriş yap",
      'haventAccont': "Hesabınız yok mu?",
      'loginError': "Giriş başarısız, lütfen tekrar deneyin.",
      'googleLoginError':
          "Google girişi başarısız oldu, lütfen tekrar deneyin.",
      'forgotPassword': "Şifremi unuttum",
      'tryAgainMessage':
          "Google girişi sırasında bir hata oluştu. Lütfen tekrar deneyin.",

      // Şifremi Unuttum Sayfası
      'buttonText': "E-posta gönder",
      'successfulMessage': "Şifre sıfırlama e-postası gönderildi: ",
      'failedMessage': "Şifre sıfırlama e-postası gönderilemedi:",

      // Kayıt Sayfası
      'supTitle': "Kişisel bilgilerinizi girin",
      'userName': "Kullanıcı adı",
      'tfUserNameHint': "Adınızı girin",
      'confirmText': "Şifreyi Onayla",
      'tfConfirmHint': "Şifrenizi tekrar girin",
      'registerError': "Kayıt başarısız oldu, lütfen tekrar deneyin.",

      // Ana Sayfa
      'newTaskCard': 'Yeni Eklenen',
      'continuesTaskCard': "Devam Eden",
      'finishedTaskCard': "Tamamlanan",

      // Görev Ekleme Sayfası
      'toastSuccessAddMessage': "Görev başarıyla eklendi!",
      'toastErrorAddMessage': "Bir hata oluştu:",
      'taskAddAppbarTitle': 'Yeni Görev',
      'tfhintTaskName': 'Görev Adı',
      'tfhintTaskDes': 'Açıklama...',
      'dropdownImportance': 'Önem Derecesi',
      'iconListTitle': 'Görev İkonu Seç',
      'saveButtonText': "Kaydet",

      // Görev Detay Sayfası
      'taskDetailAppbarTitle': "Görev Detayı",
      'categoryText': "Kategori:",

      // Görev Düzenleme Sayfası
      'toastSuccessUpdateMessage': "Görev başarıyla güncellendi!",
      'categoryNameNew': "Yeni",
      'categoryNameContinue': "Devam",
      'categoryNameFinished': "Bitti",
      'taskEditAppbarTitle': "Görev Düzenle",
      'dropdownCategory': "Durum seç",

      // Görev Listesi Sayfası
      'shortByName': 'İsme göre sırala',
      'shortByImportance': 'Öneme göre sırala',
      'delete': "Sil",
      'taskDeleted': "Görev silindi.",
      'noTask': "görev yok.",

      // Profil
      'profileAppbar': "Profil",
      'userIsNull': "Kullanıcı giriş yapmamış",
      'logoutApp': "Çıkış Yap",
      'logOutQuestionText': "Çıkış yapmak istediğinizden emin misiniz?",
      'logOutNotificationTitle': "Oturum kapatıldı!",
      'logOutNotificationDescription': "Gittiğinizi görmek üzücü.",
      'appLanguage': "Uygulama dili: Türkçe",


      // Profil Düzenleme
      'profileEditAppbar': "İsim Düzenle",
      'enterName': "Adınızı girin",
      'enterEmail': "E-posta adresinizi girin",
      'toastSuccessUpdateNameMessage': "İsim başarıyla güncellendi!",
      'alertDialogVertificationQuestion':
          "Size bir doğrulama bağlantısı göndereceğiz. Hala devam etmek istiyor musunuz?",
      'toastErrorUpdateNameMessage': "İsim güncellenirken bir hata oluştu:",
    },
  };

  static String getString(String key, String languageCode) {
    return _localizedValues[languageCode]?[key] ?? key;
  }
}

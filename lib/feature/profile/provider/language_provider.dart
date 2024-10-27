import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/product/constants/project_strings.dart';

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});

extension LocalizedStrings on String {
  String localize(WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    return ProjectStrings.getString(this, locale.languageCode);
  }
}

class LanguageNotifier extends StateNotifier<Locale> {
  // Default language
  LanguageNotifier() : super(Locale('en', 'US')) {
    _loadSavedLanguage();
  }

  static String _languageKey = _LanguageKey.seleceted.value;

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(_languageKey);
    if (savedLanguage != null) {
      state = Locale(savedLanguage, savedLanguage.toUpperCase());
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    state = Locale(languageCode, languageCode.toUpperCase());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }
}

enum _LanguageKey {
  seleceted('selected_language');

  final String value;

  const _LanguageKey(this.value);
}

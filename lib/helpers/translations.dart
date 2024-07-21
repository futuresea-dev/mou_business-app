import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Preferences related
///
const String _storageKey = "MyApplication_";
const List<String> _supportedLanguages = ['en', 'pt', 'es'];
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class GlobalTranslations {
  Locale? _locale;
  Map<dynamic, dynamic>? _localizedValues;
  VoidCallback? _onLocaleChangedCallback;

  ///
  /// Returns the list of supported Locales
  ///
  Iterable<Locale> supportedLocales() => _supportedLanguages.map((lang) => Locale(lang));

  ///
  /// Returns the translation that corresponds to the [key]
  ///
  String text(String key) {
    // Return the requested string
    return (_localizedValues == null || _localizedValues?[key] == null)
        ? '** $key not found'
        : _localizedValues?[key];
  }

  ///
  /// Returns the current language code
  ///
  String get currentLanguage => _locale == null ? '' : (_locale?.languageCode ?? "");

  ///
  /// Returns the current Locale
  ///
  get locale => _locale;

  ///
  /// One-time initialization
  ///
  Future<void> init([String? language]) async {
    if (_locale == null) {
      await setNewLanguage(language ?? "");
    }
  }

  /// ----------------------------------------------------------
  /// Method that saves/restores the preferred language
  /// ----------------------------------------------------------
  Future<String> getPreferredLanguage() => _getApplicationSavedInformation('language');

  Future<bool> setPreferredLanguage(String lang) =>
      _setApplicationSavedInformation('language', lang);

  ///
  /// Routine to change the language
  ///
  Future<void> setNewLanguage([String? newLanguage, bool saveInPrefs = false]) async {
    String? language = newLanguage;
    if (language == null) {
      language = await getPreferredLanguage();
    }
    if (language.isEmpty) {
      language = Platform.localeName.split('_').first;
    }

    // Set the locale
    language = _supportedLanguages.firstWhereOrNull((e) => language?.contains(e) ?? false) ??
        _supportedLanguages.first;

    _locale = Locale(language);

    // Load the language strings
    String jsonContent = await rootBundle.loadString("locale/i18n_$language.json");
    _localizedValues = json.decode(jsonContent);

    // If we are asked to save the new language in the application preferences
    if (saveInPrefs) {
      await setPreferredLanguage(language);
    }

    // If there is a callback to invoke to notify that a language has changed
    _onLocaleChangedCallback?.call();
  }

  ///
  /// Callback to be invoked when the user changes the language
  ///
  set onLocaleChangedCallback(VoidCallback callback) {
    _onLocaleChangedCallback = callback;
  }

  ///
  /// Application Preferences related
  ///
  /// ----------------------------------------------------------
  /// Generic routine to fetch an application preference
  /// ----------------------------------------------------------
  Future<String> _getApplicationSavedInformation(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(_storageKey + name) ?? '';
  }

  /// ----------------------------------------------------------
  /// Generic routine to saves an application preference
  /// ----------------------------------------------------------
  Future<bool> _setApplicationSavedInformation(String name, String value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(_storageKey + name, value);
  }

  ///
  /// Singleton Factory
  ///
  static final GlobalTranslations _translations = new GlobalTranslations._internal();

  factory GlobalTranslations() {
    return _translations;
  }

  GlobalTranslations._internal();
}

GlobalTranslations allTranslations = new GlobalTranslations();

GlobalTranslations get S => allTranslations;

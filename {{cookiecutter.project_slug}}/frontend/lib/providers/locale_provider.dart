import 'package:flutter/material.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final localeProvider = ChangeNotifierProvider((_) => LocaleProvider());

const _localeKey = 'locale';
const _defaultLocale = 'en';

class LocaleProvider extends ChangeNotifier {
  late Box<String> _hiveBox;
  Locale _locale = const Locale(_defaultLocale);
  bool _isLoading = true;

  Future<void> init() async {
    try {
      _hiveBox = await Hive.openBox<String>('locale');
      final localeCode = _hiveBox.get(_localeKey);
      _locale = Locale(localeCode ?? _defaultLocale);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Locale get locale {
    return _locale;
  }

  set locale(Locale locale) {
    if (!L10n.supportedLocales.contains(locale)) return;
    _locale = locale;
    _hiveBox.put(_localeKey, locale.languageCode);
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }
}

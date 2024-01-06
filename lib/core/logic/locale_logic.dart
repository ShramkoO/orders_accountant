import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleLogic {
  AppLocalizations? _strings;
  AppLocalizations get strings => _strings!;

  bool get isLoaded => _strings != null;

  final Locale _defaultLocale = const Locale('en');

  Future<void> load() async {
    Locale locale = _defaultLocale;

    if (AppLocalizations.supportedLocales.contains(locale) == false) {
      locale = _defaultLocale;
    }

    settingsCubit.changeLocale(locale);
    _strings = await AppLocalizations.delegate.load(locale);
  }

  Future<void> loadIfChanged(Locale locale) async {
    bool didChange = _strings?.localeName != locale.languageCode;
    if (didChange && AppLocalizations.supportedLocales.contains(locale)) {
      _strings = await AppLocalizations.delegate.load(locale);
    }
  }
}

extension LocaleExtension on Locale {
  String toFullName() {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      default:
        return 'Unknown';
    }
  }
}

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Orders Accountant';

  @override
  String get appModalsButtonOk => 'Ok';

  @override
  String get appModalsButtonCancel => 'Abbrechen';

  @override
  String get localeSwapButton => 'English';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';
}

part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.widgetsFactory = const AndroidWidgetsFactory(),
    this.currentLocale = const Locale('de'),
    this.userTheme = ThemeMode.system,
    this.forceIos = false,
    this.hasCompletedOnboarding = false,
  });

  final IPlatformWidgetsFactory widgetsFactory;
  final Locale currentLocale;
  final ThemeMode userTheme;
  final bool forceIos;
  final bool hasCompletedOnboarding;

  SettingsState update({
    IPlatformWidgetsFactory? widgetsFactory,
    Locale? currentLocale,
    ThemeMode? userTheme,
    bool? forceIos,
    bool? hasCompletedOnboarding,
  }) {
    return SettingsState(
      widgetsFactory: widgetsFactory ?? this.widgetsFactory,
      currentLocale: currentLocale ?? this.currentLocale,
      userTheme: userTheme ?? this.userTheme,
      forceIos: forceIos ?? this.forceIos,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
    );
  }

  @override
  List<Object?> get props => [
        widgetsFactory,
        currentLocale,
        forceIos,
        userTheme,
        hasCompletedOnboarding,
      ];
}

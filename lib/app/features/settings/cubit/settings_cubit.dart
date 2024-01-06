import 'package:orders_accountant/app/widgets/platform/platform_widget_factory.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/core/utils/helpers/save_load_mixin.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl_standalone.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> with ThrottledSaveLoadMixin {
  SettingsCubit() : super(const SettingsState());

  @override
  String get fileName => 'settings.dat';

  @override
  Future<void> copyFromJson(Map<String, dynamic> value) async {
    emit(
      SettingsState(
        hasCompletedOnboarding: value['hasCompletedOnboarding'] ?? false,
        currentLocale: value['currentLocale'] != null
            ? Locale(value['currentLocale'])
            : Locale(await findSystemLocale()),
        userTheme: themeFromString(value['userTheme']) ?? ThemeMode.system,
        forceIos: value['forceIos'] ?? false,
        widgetsFactory: value['forceIos'] ?? false
            ? const IosWidgetsFactory()
            : const AndroidWidgetsFactory(),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding': state.hasCompletedOnboarding,
      'currentLocale': state.currentLocale.languageCode,
      'userTheme': state.userTheme.toString(),
      'forceIos': state.forceIos,
    };
  }

  void forceIos(bool val) {
    emit(state.update(
      forceIos: val,
      widgetsFactory:
          val ? const IosWidgetsFactory() : const AndroidWidgetsFactory(),
    ));
  }

  void changeTheme(bool useDarkMode) {
    emit(
      state.update(userTheme: useDarkMode ? ThemeMode.dark : ThemeMode.light),
    );
  }

  void changeLocale(Locale value) {
    emit(state.update(currentLocale: value));
  }

  void completeOnboarding() {
    emit(state.update(hasCompletedOnboarding: true));
  }

  themeFromString(String? v) {
    switch (v) {
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}

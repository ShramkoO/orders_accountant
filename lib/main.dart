import 'package:cuckoo_starter_kit/core/di/locator.dart';
import 'package:cuckoo_starter_kit/app/features/auth/cubit/auth_cubit.dart';
import 'package:cuckoo_starter_kit/app/features/home/cubit/home_cubit.dart';
import 'package:cuckoo_starter_kit/app/features/settings/cubit/settings_cubit.dart';
import 'package:cuckoo_starter_kit/app/features/startup/cubit/startup_cubit.dart';
import 'package:cuckoo_starter_kit/app/widgets/platform/platform_widget_factory.dart';
import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
import 'package:cuckoo_starter_kit/cuckoo_starter_kit_app.dart';
import 'package:cuckoo_starter_kit/core/logic/locale_logic.dart';
import 'package:cuckoo_starter_kit/data/repositories/user_repository.dart';
import 'package:cuckoo_starter_kit/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  // await settingsLogic.load();

  await configureInjection();

  runApp(provideBlocsTo(const CuckooStarterKitApp()));
  await startupCubit.startup();
}

UserRepository get userRepository => locator();

SettingsCubit get settingsCubit => locator();
StartupCubit get startupCubit => locator();
UserInfoCubit get userInfoCubit => locator();
AuthCubit get authCubit => locator();
HomeCubit get homeCubit => locator();

LocaleLogic localeLogic = LocaleLogic();
AppLocalizations get strings => localeLogic.strings;
IPlatformWidgetsFactory get widgets => settingsCubit.state.widgetsFactory;
final styles = AppStyle();
final textStyles = styles.text;
final colors = styles.colors;

Widget provideBlocsTo(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<StartupCubit>(
        create: (_) => startupCubit,
      ),
      BlocProvider<SettingsCubit>(
        create: (_) => settingsCubit,
      ),
      BlocProvider<UserInfoCubit>(
        create: (_) => userInfoCubit,
      ),
      BlocProvider<AuthCubit>(
        create: (_) => authCubit,
      ),
      BlocProvider<SettingsCubit>(
        create: (_) => settingsCubit,
      ),
      BlocProvider<HomeCubit>(
        create: (_) => homeCubit,
      ),
    ],
    child: BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        settingsCubit.scheduleSave();
      },
      child: child,
    ),
  );
}

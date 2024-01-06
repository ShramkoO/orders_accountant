import 'package:orders_accountant/core/di/locator.dart';
import 'package:orders_accountant/app/features/auth/cubit/auth_cubit.dart';
import 'package:orders_accountant/app/features/home/cubit/home_cubit.dart';
import 'package:orders_accountant/app/features/settings/cubit/settings_cubit.dart';
import 'package:orders_accountant/app/features/startup/cubit/startup_cubit.dart';
import 'package:orders_accountant/app/widgets/platform/platform_widget_factory.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/orders_accountant_app.dart';
import 'package:orders_accountant/core/logic/locale_logic.dart';
import 'package:orders_accountant/data/repositories/user_repository.dart';
import 'package:orders_accountant/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  // await settingsLogic.load();

  await configureInjection();

  runApp(provideBlocsTo(const OrdersAccountantApp()));
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

import 'package:orders_accountant/app/widgets/app_wrapper.dart';
import 'package:orders_accountant/app/features/settings/cubit/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/common_libs.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersAccountantApp extends StatefulWidget {
  const OrdersAccountantApp({super.key});

  @override
  State<OrdersAccountantApp> createState() => _OrdersAccountantAppState();
}

class _OrdersAccountantAppState extends State<OrdersAccountantApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.routerDelegate,
          routeInformationParser: appRouter.routeInformationParser,
          routeInformationProvider: appRouter.routeInformationProvider,
          theme: colors.toThemeData(isDark: false),
          darkTheme: colors.toThemeData(isDark: true),
          themeMode: settingsCubit.state.userTheme,
          locale: settingsCubit.state.currentLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (BuildContext context, Widget? child) {
            return AppWrapper(child: child!);
          },
        );
      },
    );
  }
}

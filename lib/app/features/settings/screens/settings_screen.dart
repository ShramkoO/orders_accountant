import 'package:orders_accountant/main.dart';
import 'package:orders_accountant/app/features/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SettingsList(
          platform: state.forceIos ? DevicePlatform.iOS : DevicePlatform.device,
          sections: [
            SettingsSection(
              title: const Text('Design'),
              tiles: [
                SettingsTile.switchTile(
                  title: const Text('Dark Mode'),
                  initialValue: state.userTheme == ThemeMode.dark,
                  onToggle: (bool v) => settingsCubit.changeTheme(v),
                ),
                SettingsTile.switchTile(
                  enabled: true, //!PlatformInfo.isIOS,
                  initialValue: state.forceIos,
                  onToggle: (val) => settingsCubit.forceIos(val),
                  title: const Text('iOS Mode'),
                ),
              ],
            ),
            SettingsSection(
              title: const Text('Account'),
              tiles: [
                SettingsTile.navigation(
                  leading: const Icon(Icons.logout),
                  title: const Text('Abmelden'),
                  onPressed: (_) async {
                    bool res = await state.widgetsFactory.createPopup().show(
                          context: context,
                          title: 'Abmelden',
                          msg: 'Willst du dich wirklich abmelden?',
                        );
                    if (res) await authCubit.signOut();
                  },
                ),
              ],
            ),
          ],
        );
        // return Padding(
        //   padding: EdgeInsets.all(styles.insets.body),
        //   child: ListView(
        //     children: [
        //       Card(
        //         margin: EdgeInsets.zero,
        //         child: ListTile(
        //           title: const Text('Theme'),
        //           trailing: ValueListenableBuilder<UserTheme?>(
        //             valueListenable: settingsLogic.userTheme,
        //             builder: (context, value, child) => DropdownButton(
        //               value: value,
        //               items: const [
        //                 DropdownMenuItem(
        //                   value: UserTheme.system,
        //                   child: Text('System'),
        //                 ),
        //                 DropdownMenuItem(
        //                   value: UserTheme.light,
        //                   child: Text('Light'),
        //                 ),
        //                 DropdownMenuItem(
        //                   value: UserTheme.dark,
        //                   child: Text('Dark'),
        //                 ),
        //               ],
        //               onChanged: (UserTheme? newTheme) {
        //                 settingsLogic.userTheme.value = newTheme;
        //               },
        //             ),
        //           ),
        //         ),
        //       ),
        //       Gap(styles.insets.sm),
        //       Card(
        //         margin: EdgeInsets.zero,
        //         child: ListTile(
        //           title: Text(strings.language),
        //           trailing: ValueListenableBuilder<String?>(
        //             valueListenable: settingsLogic.currentLocale,
        //             builder: (context, value, child) => DropdownButton(
        //               value: value,
        //               items: [
        //                 for (Locale l in AppLocalizations.supportedLocales)
        //                   DropdownMenuItem(
        //                     value: l.languageCode,
        //                     child: Text(l.toFullName()),
        //                   ),
        //               ],
        //               onChanged: (String? newLocale) async {
        //                 await settingsLogic.changeLocale(newLocale!);
        //               },
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }
}

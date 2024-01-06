import 'package:cuckoo_starter_kit/app/features/auth/cubit/auth_cubit.dart';
import 'package:cuckoo_starter_kit/app/features/auth/screens/sign_up_screen.dart';
import 'package:cuckoo_starter_kit/app/features/settings/cubit/settings_cubit.dart';
import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
import 'package:cuckoo_starter_kit/core/di/locator.dart';
import 'package:cuckoo_starter_kit/cuckoo_starter_kit_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

// flutter test --update-goldens

void main() {
  MockSettingsCubit mockSettingsCubit = MockSettingsCubit();
  MockAuthCubit mockAuthCubit = MockAuthCubit();

  setUpAll(() async {
    GetIt.I.registerLazySingleton<SettingsCubit>(() => mockSettingsCubit);
    GetIt.I.registerLazySingleton<AuthCubit>(() => mockAuthCubit);

    when(() => mockSettingsCubit.state).thenReturn(const SettingsState());
    when(() => mockAuthCubit.state).thenReturn(Unauthenticated());
  });

  testWidgets('Golden test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(create: (_) => mockSettingsCubit),
        BlocProvider<AuthCubit>(create: (_) => mockAuthCubit),
      ],
      child: const MaterialApp(home: Scaffold(body: SignUpScreen())),
    ));
    await expectLater(
        find.byType(SignUpScreen), matchesGoldenFile('sign_up_screen.png'));
  });
}

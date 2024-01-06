import 'package:bloc_test/bloc_test.dart';
import 'package:orders_accountant/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

void main() {
  group('User Info Cubit', () {
    blocTest<UserInfoCubit, UserInfoState>(
      '',
      build: () => UserInfoCubit(),
      wait: Duration.zero,
      expect: () => [],
    );

    blocTest<UserInfoCubit, UserInfoState>(
      '',
      build: () => UserInfoCubit(),
      act: (cubit) => cubit.showSnackbar(
        message: 'Test Message',
        severity: MessageSeverity.error,
      ),
      skip: 1,
      expect: () => [
        const UserInfoState(
          message: 'Test Message',
          severity: MessageSeverity.error,
          showSnackbar: true,
        ),
      ],
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:orders_accountant/app/features/auth/cubit/auth_cubit.dart';
import 'package:orders_accountant/app/features/settings/cubit/settings_cubit.dart';
import 'package:orders_accountant/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:orders_accountant/domain/repositories/iuser_repository.dart';
import 'package:orders_accountant/domain/services/iauth_service.dart';
import 'package:orders_accountant/domain/services/idatabase_service.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabaseService extends Mock implements IDatabaseService {}

class MockAuthService extends Mock implements IAuthService {}

class MockUserRepository extends Mock implements IUserRepository {}

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

class AuthStateFake extends Fake implements AuthState {}

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

class MockUserInfoCubit extends MockCubit<UserInfoState>
    implements UserInfoCubit {}

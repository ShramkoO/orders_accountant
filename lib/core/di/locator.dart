import 'package:orders_accountant/app/features/orders/cubit/edit_order_cubit.dart';
import 'package:orders_accountant/app/features/orders/cubit/orders_cubit.dart';
import 'package:orders_accountant/app/features/products/cubit/products_cubit.dart';
import 'package:orders_accountant/app/features/statistics/cubit/statistics_cubit.dart';
import 'package:orders_accountant/data/repositories/user_repository.dart';
import 'package:orders_accountant/data/services/auth_service.dart';
import 'package:orders_accountant/data/services/database_service.dart';
import 'package:orders_accountant/data/services/supabase_service.dart';
import 'package:orders_accountant/domain/repositories/categories_repository.dart';
import 'package:orders_accountant/domain/repositories/iuser_repository.dart';
import 'package:orders_accountant/domain/repositories/orders_repository.dart';
import 'package:orders_accountant/domain/repositories/products_repository.dart';
import 'package:orders_accountant/domain/services/iauth_service.dart';
import 'package:orders_accountant/domain/services/idatabase_service.dart';
import 'package:orders_accountant/app/features/auth/cubit/auth_cubit.dart';
import 'package:orders_accountant/app/features/home/cubit/home_cubit.dart';
import 'package:orders_accountant/app/features/settings/cubit/settings_cubit.dart';
import 'package:orders_accountant/app/features/startup/cubit/startup_cubit.dart';
import 'package:orders_accountant/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> configureInjection() async {
  locator.registerSingleton<SupabaseService>(await SupabaseService.init());

  final supabaseClient = locator<SupabaseService>().client;

  locator.registerLazySingleton<IAuthService>(() => AuthService(
        auth: locator<SupabaseService>().client.auth,
      ));
  locator.registerLazySingleton<IDatabaseService>(() => DatabaseService(
        supabaseClient: supabaseClient,
      ));

  locator.registerLazySingleton<IUserRepository>(() => UserRepository(
        authService: locator(),
        databaseService: locator(),
      ));

  locator.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepository(supabaseClient: supabaseClient));
  locator.registerLazySingleton<ProductsRepository>(
      () => ProductsRepository(supabaseClient: supabaseClient));
  locator.registerLazySingleton<OrdersRepository>(
      () => OrdersRepository(supabaseClient: supabaseClient));

  locator.registerLazySingleton<SettingsCubit>(() => SettingsCubit());
  locator.registerLazySingleton<StartupCubit>(() => StartupCubit(
        authService: locator(),
        userRepository: locator(),
      ));
  locator.registerLazySingleton<UserInfoCubit>(() => UserInfoCubit());
  locator.registerLazySingleton<AuthCubit>(() => AuthCubit(
        userRepository: locator(),
      ));

  locator.registerLazySingleton<HomeCubit>(() => HomeCubit());
  locator.registerLazySingleton<ProductsCubit>(() => ProductsCubit(
        categoriesRepository: locator(),
        productsRepository: locator(),
      ));
  locator.registerLazySingleton<OrdersCubit>(
      () => OrdersCubit(ordersRepository: locator()));
  locator.registerLazySingleton<EditOrderCubit>(
      () => EditOrderCubit(ordersRepository: locator()));
  locator.registerLazySingleton<StatisticsCubit>(() => StatisticsCubit());
}

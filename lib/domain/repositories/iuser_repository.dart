import 'dart:async';

import 'package:orders_accountant/data/services/auth_service.dart';
import 'package:orders_accountant/domain/models/app_user.dart';
import 'package:orders_accountant/core/common/domain/data_state.dart';

abstract class IUserRepository {
  Future<void> init();

  AppUser? get currentUser;

  Stream<AppUser?> get userStream;

  Stream<AppAuthStatus> get authStatusStream;

  Future<DataState<void>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<DataState<void>> signUpWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<DataState<void>> signOut();

  Future<DataState<void>> resetPassword({required String email});

  Future<DataState<void>> updatePassword({required String newPassword});

  Future<DataState<AppUser>> getUserData();

  Future<DataState<AppUser>> updateUserData({required AppUser user});
}

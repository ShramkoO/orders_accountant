import 'dart:async';

import 'package:cuckoo_starter_kit/main.dart';
import 'package:cuckoo_starter_kit/domain/repositories/iuser_repository.dart';
import 'package:cuckoo_starter_kit/core/router/router.dart';
import 'package:cuckoo_starter_kit/data/services/auth_service.dart';
import 'package:cuckoo_starter_kit/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:cuckoo_starter_kit/core/utils/helpers/debug_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required IUserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthLoading());

  final IUserRepository _userRepository;

  late StreamSubscription _userSub;

  Future<void> init() async {
    _userSub = _userRepository.authStatusStream.listen((AppAuthStatus status) {
      if (status == AppAuthStatus.passwordRecovery) {
        emit(const PasswordRecovery());
        // appRouter.go(ScreenPaths.newPassword);
      } else if (status == AppAuthStatus.authenticated) {
        emit(const Authenticated());
      } else if (status == AppAuthStatus.unauthenticated) {
        emit(Unauthenticated());
      } else if (status == AppAuthStatus.loading) {
        emit(AuthLoading());
      }
    });
  }

  @override
  Future<void> close() async {
    _userSub.cancel();
    super.close();
  }

  Future<void> resetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await _userRepository.resetPassword(email: email);
      userInfoCubit.showSnackbar(
        message: 'Password reset email sent if account with given email exists',
        severity: MessageSeverity.success,
      );
    } catch (e) {
      userInfoCubit.showSnackbar(
          message: e.toString(), severity: MessageSeverity.error);
    } finally {
      emit(Unauthenticated());
    }
  }

  Future<void> updatePassword({required String newPassword}) async {
    try {
      await _userRepository.updatePassword(newPassword: newPassword);
      userInfoCubit.showSnackbar(
        message: 'Password updated!',
        severity: MessageSeverity.success,
      );
      appRouter.go(ScreenPaths.home);
    } on AuthException catch (e) {
      userInfoCubit.showSnackbar(
          message: e.message, severity: MessageSeverity.error);
    } catch (e) {
      userInfoCubit.showSnackbar(
          message: 'An error occured', severity: MessageSeverity.error);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await _userRepository.signInWithEmailAndPassword(
          email: email, password: password);
    } on AuthException catch (error) {
      debugLog(error.message);
      userInfoCubit.showSnackbar(
          message: error.message, severity: MessageSeverity.error);
      emit(AuthError(error: error.message));
    } catch (error) {
      debugLog(error.toString());
      userInfoCubit.showSnackbar(
          message: 'Unexpected error occured', severity: MessageSeverity.error);
      emit(const AuthError(error: 'Unexpected error occured'));
    }
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _userRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
    } on AuthException catch (error) {
      userInfoCubit.showSnackbar(
          message: error.message, severity: MessageSeverity.error);
      emit(AuthError(error: error.message));
    } catch (error) {
      userInfoCubit.showSnackbar(
          message: 'Unexpected error occured', severity: MessageSeverity.error);
      emit(const AuthError(error: 'Unexpected error occured'));
    } finally {
      emit(Unauthenticated());
    }
  }

  Future<void> signOut() async {
    await _userRepository.signOut();
    appRouter.go(ScreenPaths.signUp);
  }
}

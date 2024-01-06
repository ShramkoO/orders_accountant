part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final String? error;

  const AuthState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  const Authenticated();
}

class Unauthenticated extends AuthState {}

class PasswordRecovery extends AuthState {
  const PasswordRecovery();
}

class AuthError extends AuthState {
  const AuthError({super.error});
}

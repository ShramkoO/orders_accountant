import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(const UserInfoState.initial());

  void showSnackbar({
    required String message,
    required MessageSeverity severity,
  }) {
    emit(state.update(showSnackbar: false));
    emit(state.update(
      message: message,
      severity: severity,
      showSnackbar: true,
    ));
  }
}

class UserInfoState extends Equatable {
  const UserInfoState({
    required this.message,
    required this.severity,
    required this.showSnackbar,
  });

  final String message;
  final MessageSeverity severity;
  final bool showSnackbar;

  const UserInfoState.initial({
    this.message = '',
    this.severity = MessageSeverity.info,
    this.showSnackbar = false,
  });

  UserInfoState update({
    String? message,
    MessageSeverity? severity,
    bool? showSnackbar,
    bool? showPopup,
  }) {
    return UserInfoState(
      message: message ?? this.message,
      severity: severity ?? this.severity,
      showSnackbar: showSnackbar ?? this.showSnackbar,
    );
  }

  @override
  List<Object?> get props => [message, severity, showSnackbar];
}

enum MessageSeverity {
  info,
  warning,
  error,
  success,
}

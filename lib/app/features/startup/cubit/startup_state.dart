part of 'startup_cubit.dart';

class StartupState {
  final bool startupFinished;
  final String? redirectTo;

  StartupState({required this.startupFinished, this.redirectTo});

  StartupState update({
    bool? startupFinished,
    String? redirectTo,
  }) {
    return StartupState(
      startupFinished: startupFinished ?? this.startupFinished,
      redirectTo: redirectTo ?? this.redirectTo,
    );
  }
}

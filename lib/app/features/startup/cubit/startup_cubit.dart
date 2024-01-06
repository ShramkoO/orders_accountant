import 'dart:async';

// import '../../../trash/iauth_repository.dart';
import 'package:cuckoo_starter_kit/domain/repositories/iuser_repository.dart';
import 'package:cuckoo_starter_kit/domain/services/iauth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';

part 'startup_state.dart';

/// The StartupCubit handles the initial bootstrap of the app.
/// It initiailizes all the Repositories and Services.
/// It also exposes a Completer that finishes once the startup() method completes
class StartupCubit extends Cubit<StartupState> {
  StartupCubit({
    required IUserRepository userRepository,
    required IAuthService authService,
  })  : _userRepository = userRepository,
        _authService = authService,
        super(StartupState(startupFinished: false));

  final IUserRepository _userRepository;
  final IAuthService _authService;

  Future<void> get initialStartup => _startupCompleter.future;
  late Completer<void> _startupCompleter;

  Future<void> startup() async {
    _startupCompleter = Completer();

    await initConfig();

    await settingsCubit.load();

    await localeLogic.load();

    await authCubit.init();
    await _userRepository.init();
    await _authService.init();

    _startupCompleter.complete();
  }

  Future<void> initConfig() async {
    FlutterError.onError = _handleFlutterError;

    setDeviceOrientation(Axis.vertical);

    if (defaultTargetPlatform == TargetPlatform.android) {
      await FlutterDisplayMode.setHighRefreshRate();
    }
  }

  void finishStartup() {
    emit(state.update(startupFinished: true));
  }

  void setRedirectPath(String path) {
    emit(state.update(redirectTo: path));
  }

  void setDeviceOrientation(Axis? axis) {
    final orientations = <DeviceOrientation>[];
    if (axis == null || axis == Axis.vertical) {
      orientations.addAll([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    if (axis == null || axis == Axis.horizontal) {
      orientations.addAll([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    SystemChrome.setPreferredOrientations(orientations);
  }

  // Use this if you want to implement custom error handling
  void _handleFlutterError(FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  }
}

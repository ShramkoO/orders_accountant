import 'dart:async';

import 'package:orders_accountant/domain/models/app_user.dart';
import 'package:orders_accountant/core/common/domain/base_repository.dart';
import 'package:orders_accountant/domain/repositories/iuser_repository.dart';
import 'package:orders_accountant/domain/services/iauth_service.dart';
import 'package:orders_accountant/domain/services/idatabase_service.dart';
import 'package:orders_accountant/data/services/auth_service.dart';
import 'package:orders_accountant/core/common/domain/data_state.dart';

class UserRepository extends BaseRepository implements IUserRepository {
  UserRepository({
    required IAuthService authService,
    required IDatabaseService databaseService,
  })  : _authService = authService,
        _databaseService = databaseService;

  final IAuthService _authService;
  final IDatabaseService _databaseService;

  AppUser? _currentUser;
  @override
  AppUser? get currentUser => _currentUser;

  StreamController<AppUser?> userStreamController =
      StreamController.broadcast();
  StreamController<AppAuthStatus> authStatusStreamController =
      StreamController.broadcast();

  @override
  Stream<AppUser?> get userStream => userStreamController.stream;

  @override
  Stream<AppAuthStatus> get authStatusStream =>
      _authService.appAuthStatusStream;

  @override
  Future<void> init() async {
    _authService.appAuthStatusStream.listen((AppAuthStatus status) async {
      if (status == AppAuthStatus.authenticated) {
        // final AppUser user = await _databaseService.getUser();
        // _currentUser = user;
        // userStreamController.add(user);
      } else if (status == AppAuthStatus.unauthenticated) {
        _currentUser = null;
        userStreamController.add(null);
      }
    });
  }

  @override
  Future<DataState<void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return call(() => _authService.signInWithEmailAndPassword(
        email: email, password: password));
  }

  @override
  Future<DataState<void>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return call(() => _authService.signUpWithEmailAndPassword(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        ));
  }

  @override
  Future<DataState<void>> signOut() async {
    return call(() => _authService.signOut());
  }

  @override
  Future<DataState<void>> resetPassword({required String email}) async {
    return call(() => _authService.resetPassword(email: email));
  }

  @override
  Future<DataState<void>> updatePassword({required String newPassword}) async {
    return call(() => _authService.updatePassword(newPassword: newPassword));
  }

  @override
  Future<DataState<AppUser>> getUserData() {
    return call(() => _databaseService.getUser());
  }

  @override
  Future<DataState<AppUser>> updateUserData({required AppUser user}) {
    return call(() => _databaseService.updateUser(user: user));
  }
}

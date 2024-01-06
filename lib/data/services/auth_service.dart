import 'dart:async';

import 'package:cuckoo_starter_kit/domain/services/iauth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService implements IAuthService {
  AuthService({
    required GoTrueClient auth,
  }) : _auth = auth;

  final GoTrueClient _auth;

  StreamController<AppAuthStatus> appAuthStatusStreamController =
      StreamController.broadcast();

  @override
  Stream<AppAuthStatus> get appAuthStatusStream =>
      appAuthStatusStreamController.stream;

  @override
  Future<void> init() async {
    final session = await SupabaseAuth.instance.initialSession;

    if (session == null) {
      appAuthStatusStreamController.add(AppAuthStatus.unauthenticated);
    } else {
      appAuthStatusStreamController.add(AppAuthStatus.authenticated);
    }

    _auth.onAuthStateChange.listen((AuthState authState) async {
      final e = authState.event;
      if (e == AuthChangeEvent.signedOut || e == AuthChangeEvent.userDeleted) {
        appAuthStatusStreamController.add(AppAuthStatus.unauthenticated);
      } else if (e == AuthChangeEvent.passwordRecovery) {
        appAuthStatusStreamController.add(AppAuthStatus.passwordRecovery);
      } else if (e == AuthChangeEvent.signedIn) {
        appAuthStatusStreamController.add(AppAuthStatus.authenticated);
      }
    });
  }

  @override
  Future<void> resetPassword({required String email}) async {
    _auth.resetPasswordForEmail(email,
        redirectTo: 'cuckoo://auth/password-reset');
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _auth.signInWithPassword(password: password, email: email);
  }

  @override
  Future<void> signInWithGoogle(
      {required String idToken, required String nonce}) async {
    await _auth.signInWithIdToken(
      provider: Provider.google,
      idToken: idToken,
      nonce: nonce,
    );
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    _auth.signUp(
      email: email,
      password: password,
      data: {'first_name': firstName, 'last_name': lastName},
      emailRedirectTo: 'cuckoo://auth/confirm-email',
    );
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {
    await _auth.updateUser(UserAttributes(password: newPassword));
  }
}

enum AppAuthStatus {
  unauthenticated,
  authenticated,
  passwordRecovery,
  initial,
  loading,
}

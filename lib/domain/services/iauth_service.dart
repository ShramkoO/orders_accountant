import 'package:cuckoo_starter_kit/data/services/auth_service.dart';

abstract class IAuthService {
  Future<void> init();

  Stream<AppAuthStatus> get appAuthStatusStream;

  Future<void> signUpWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signInWithGoogle(
      {required String idToken, required String nonce});

  Future<void> signOut();

  Future<void> resetPassword({required String email});

  Future<void> updatePassword({required String newPassword});
}

import 'package:cuckoo_starter_kit/domain/models/app_user.dart';

abstract class IDatabaseService {
  Future<AppUser> getUser();

  Future<void> updateUser({required AppUser user});
}

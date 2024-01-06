import 'package:orders_accountant/domain/models/app_user.dart';

abstract class IDatabaseService {
  Future<AppUser> getUser();

  Future<void> updateUser({required AppUser user});
}

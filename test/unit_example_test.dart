import 'package:cuckoo_starter_kit/domain/models/app_user.dart';
import 'package:test/test.dart';

void main() {
  group('AppUser class', () {
    AppUser baseUser = const AppUser(firstName: 'Test', lastName: 'User');
    test('Should return full name', () {
      AppUser user = baseUser;
      expect(user.fullName, 'Test User');
    });
    test('Should trim names', () {
      AppUser user =
          baseUser.copyWith(firstName: '   Test', lastName: 'User   ');

      expect(user.fullName, 'Test User');
    });
    test('Should trim firstname', () {
      AppUser user = baseUser.copyWith(lastName: '');

      expect(user.fullName, 'Test');
    });
    test('Should trim lastname', () {
      AppUser user = baseUser.copyWith(firstName: '');

      expect(user.fullName, 'User');
    });
  });
}

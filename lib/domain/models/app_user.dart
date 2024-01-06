import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    String? id,
    required this.firstName,
    required this.lastName,
  }) : id = id ?? '';

  final String id;
  final String firstName;
  final String lastName;

  String get fullName => ('$firstName $lastName').trim();

  AppUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
  }) {
    return AppUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName];
}

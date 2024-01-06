import 'dart:convert';

import 'package:cuckoo_starter_kit/domain/models/app_user.dart';

class AppUserDto extends AppUser {
  const AppUserDto({
    super.id,
    required super.firstName,
    required super.lastName,
  });

  factory AppUserDto.fromJson(String raw) =>
      AppUserDto.fromMap(json.decode(raw));

  String toJson() => json.encode(toMap());

  factory AppUserDto.fromMap(Map<String, dynamic> json) => AppUserDto(
        id: json['id'] as String?,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
      };
}

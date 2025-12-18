import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_role.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    required UserRole role,
  }) = _User;

  const User._();

  String get roleDisplayName => role.displayName;
}
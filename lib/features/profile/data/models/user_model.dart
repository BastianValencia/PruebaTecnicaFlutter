import 'package:enm/features/profile/domain/entities/user.dart';
import 'package:enm/features/profile/domain/entities/user_role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    required String role,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Conversión a entity
  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      role: UserRole.fromString(role),
    );
  }

  // Desde entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role.toJson(),
    );
  }
}
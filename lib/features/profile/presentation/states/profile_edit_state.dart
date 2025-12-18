import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'profile_edit_state.freezed.dart';

@freezed
abstract class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState({
    required User originalUser,
    required User editedUser,
    @Default(false) bool isDirty,
    @Default(false) bool isSaving,
    String? saveError,
  }) = _ProfileEditState;
  
  const ProfileEditState._();
  
  bool get hasUnsavedChanges => isDirty && !isSaving;
}
import 'package:enm/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:enm/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:enm/features/profile/domain/repositories/profile_repository.dart';
import 'package:enm/features/profile/presentation/states/profile_edit_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'profile_provider.g.dart';

// --- Dependency Injection ---

@riverpod
ProfileLocalDatasource profileLocalDatasource(Ref ref) {
  return ProfileLocalDatasource();
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final datasource = ref.watch(profileLocalDatasourceProvider);
  return ProfileRepositoryImpl(datasource);
}

// --- Notifier ---

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<ProfileEditState> build() async {
    final repository = ref.read(profileRepositoryProvider);
    final user = await repository.getUser();
    return ProfileEditState(
      originalUser: user,
      editedUser: user,
    );
  }

  /// Actualiza un campo del formulario (edición local)
  void updateField({String? name, String? email}) {
    // Solo permitimos editar si ya tenemos datos cargados
    if (state.value == null) return;

    final currentState = state.value!;
    final updatedUser = currentState.editedUser.copyWith(
      name: name ?? currentState.editedUser.name,
      email: email ?? currentState.editedUser.email,
    );

    // Comparar con original para saber si tiene errores
    final isDirty = updatedUser != currentState.originalUser;

    state = AsyncValue.data(currentState.copyWith(
      editedUser: updatedUser,
      isDirty: isDirty,
      saveError: null, // Limpiar errores previos al editar
    ));
  }

  /// Intenta guardar los cambios.
  /// Si falla (conflicto), el estado de error se refleja en la UI.
  Future<void> saveChanges() async {
    if (state.value == null) return;
    final currentState = state.value!;

    if (!currentState.isDirty) return;

    // Estado Loading
    state = AsyncValue.data(currentState.copyWith(isSaving: true, saveError: null));

    try {
      final repository = ref.read(profileRepositoryProvider);
      
      // Intentar guardar
      await repository.saveUser(currentState.editedUser);

      // Si tiene éxito, el nuevo original es el editado
      state = AsyncValue.data(currentState.copyWith(
        originalUser: currentState.editedUser,
        isDirty: false,
        isSaving: false,
      ));
      
    } catch (e) {
      // Si falla, volvemos a estado normal pero con error
      // MANTENEMOS los datos editados para que el usuario decida (regla de negocio)
      state = AsyncValue.data(currentState.copyWith(
        isSaving: false,
        saveError: e.toString(),
      ));
    }
  }

  /// Descarta los cambios locales y vuelve al original
  void discardChanges() {
    if (state.value == null) return;
    final currentState = state.value!;

    state = AsyncValue.data(currentState.copyWith(
      editedUser: currentState.originalUser,
      isDirty: false,
      saveError: null,
    ));
  }
}

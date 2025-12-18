import '../entities/user.dart';

abstract class ProfileRepository {
  /// Obtiene los datos del usuario actual.
  Future<User> getUser();

  /// Guarda los cambios del usuario.
  /// Puede lanzar una excepción si ocurre un conflicto.
  Future<void> saveUser(User user);
}

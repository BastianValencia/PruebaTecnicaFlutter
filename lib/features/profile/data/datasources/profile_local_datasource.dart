import 'dart:math';

import 'package:enm/features/profile/data/models/user_model.dart';

class ProfileLocalDatasource {
  final _random = Random();
  
  // Estado local simulado (Base de datos)
  UserModel _currentUser = const UserModel(
    id: 'user-1293',
    name: 'Juan Pérez',
    email: 'juan.perez@email.com',
    role: 'BUYER',
  );

  /// Obtiene el usuario actual
  Future<UserModel> getUser() async {
    // Simular delay db
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }

  /// Guarda el usuario.
  /// 
  /// Escenario Conflicto:
  /// - 30% de probabilidad de fallar al guardar (simulando conflicto o error de escritura)
  /// - Si falla, lanza una excepción, y el estado NO se actualiza aquí.
  Future<void> saveUser(UserModel updatedUser) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Simular fallo (Conflicto de guardado)
    if (_random.nextInt(100) < 30) {
      throw Exception('Conflicto de guardado: Los datos han cambiado en el servidor.');
    }

    // Guardado exitoso
    _currentUser = updatedUser;
  }
}

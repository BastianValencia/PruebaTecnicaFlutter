import '../../domain/entities/user.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../models/user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDatasource _datasource;

  ProfileRepositoryImpl(this._datasource);

  @override
  Future<User> getUser() async {
    final model = await _datasource.getUser();
    return model.toEntity();
  }

  @override
  Future<void> saveUser(User user) async {
    // Convertir Entity a Model para guardar
    final model = UserModel.fromEntity(user);
    await _datasource.saveUser(model);
  }
}

import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_remote_datasource.dart';
import '../models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDatasource _datasource;

  ProductsRepositoryImpl(this._datasource);

  @override
  Future<List<Product>> getProducts() async {
    final models = await _datasource.getProducts();
    // Mapear de Model a Entity
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Product> getProductDetail(String productId) async {
    final model = await _datasource.getProductDetail(productId);
    // Mapear de Model a Entity
    return model.toEntity();
  }
}

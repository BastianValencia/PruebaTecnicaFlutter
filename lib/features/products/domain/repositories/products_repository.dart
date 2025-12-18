import '../entities/product.dart';

abstract class ProductsRepository {
  /// Obtiene el listado de productos.
  /// Puede retornar una lista vacía o lanzar una excepción.
  Future<List<Product>> getProducts();

  /// Obtiene el detalle de un producto específico.
  /// Puede lanzar [ProductNotFoundException] si no existe.
  Future<Product> getProductDetail(String productId);
}

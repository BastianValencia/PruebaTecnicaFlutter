import 'package:enm/features/products/data/datasources/products_remote_datasource.dart';
import 'package:enm/features/products/data/repositories/products_repository_impl.dart';
import 'package:enm/features/products/domain/repositories/products_repository.dart';
import 'package:enm/features/products/presentation/states/products_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_provider.g.dart';

// --- Dependency Injection ---

@riverpod
ProductsRemoteDatasource productsRemoteDatasource(Ref ref) {
  return ProductsRemoteDatasource();
}

@riverpod
ProductsRepository productsRepository(Ref ref) {
  final datasource = ref.watch(productsRemoteDatasourceProvider);
  return ProductsRepositoryImpl(datasource);
}

// --- Notifier ---

@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  bool _mounted = true;

  @override
  ProductsState build() {
    _mounted = true;
    ref.onDispose(() {
      _mounted = false;
    });

    // Initial load
    Future.microtask(() => loadProducts());
    return const ProductsState(isRefreshing: true);
  }

  Future<void> loadProducts() async {
    // Solo actualizamos si está montado
    if (!_mounted) return;
    
    // Evitamos notificar si ya estamos cargando para no spammear builds
    if (!state.isRefreshing) {
       state = state.copyWith(isRefreshing: true, error: null);
    }

    try {
      final repository = ref.read(productsRepositoryProvider);
      final products = await repository.getProducts();
      
      if (!_mounted) return;

      state = state.copyWith(
        products: products,
        isRefreshing: false,
      );
    } catch (e) {
      if (!_mounted) return;
      state = state.copyWith(
        error: e.toString(),
        isRefreshing: false,
      );
    }
  }

  /// Refresca un producto específico (para view details)
  Future<void> refreshProduct(String productId) async {
    try {
      final repository = ref.read(productsRepositoryProvider);
      final product = await repository.getProductDetail(productId);
      
      if (!_mounted) return;

      // Actualizar el producto en la lista si existe
      final currentProducts = [...state.products];
      final index = currentProducts.indexWhere((p) => p.id == productId);
      
      if (index != -1) {
        currentProducts[index] = product;
        state = state.copyWith(products: currentProducts);
      }
      
      // Marcar como válido en el mapa de estados
    } on ProductNotFoundException {
       if (!_mounted) return;
       state = state.markAsMissing(productId);
    } catch (e) {
      // Otros errores no afectan el estado global del producto por ahora
    }
  }
}

import 'package:enm/features/products/data/models/product_status.dart';
import 'package:enm/features/products/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'products_state.freezed.dart';

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default([]) List<Product> products,
    @Default({}) Map<String, ProductStatus> statusMap,
    @Default(false) bool isRefreshing,
    String? error,
  }) = _ProductsState;
  
  const ProductsState._();
  
  ProductStatus getStatus(String productId) {
    return statusMap[productId] ?? ProductStatus.unknown;
  }
  
  ProductsState markAsMissing(String productId) {
    return copyWith(
      statusMap: {...statusMap, productId: ProductStatus.missing},
    );
  }
  
  ProductsState markAsStale(String productId) {
    return copyWith(
      statusMap: {...statusMap, productId: ProductStatus.stale},
    );
  }
}
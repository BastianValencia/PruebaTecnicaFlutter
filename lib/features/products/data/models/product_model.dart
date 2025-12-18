import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required double price,
    required String currency,
    required String imageUrl,
    required String location,
  }) = _ProductModel;

  const ProductModel._();

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  // Desde entity
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      currency: product.currency,
      imageUrl: product.imageUrl,
      location: product.location,
    );
  }
}

// Conversión a entity
extension ProductModelX on ProductModel {
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      price: price,
      currency: currency,
      imageUrl: imageUrl,
      location: location,
    );
  }
}
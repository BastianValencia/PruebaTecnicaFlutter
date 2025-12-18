import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:enm/core/utils/currency_formatter.dart';

part 'product.freezed.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required double price,
    required String currency,
    required String imageUrl,
    required String location,
  }) = _Product;

  const Product._();

  String get formattedPrice => CurrencyFormatter.format(price, currency: currency);
}
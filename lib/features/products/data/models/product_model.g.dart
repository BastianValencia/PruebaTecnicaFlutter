// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      id: const RobustStringConverter().fromJson(json['id']),
      name: const RobustStringConverter().fromJson(json['name']),
      price: const RobustDoubleConverter().fromJson(json['price']),
      currency: const RobustStringConverter().fromJson(json['currency']),
      imageUrl: const RobustStringConverter().fromJson(json['imageUrl']),
      location: const RobustStringConverter().fromJson(json['location']),
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': const RobustStringConverter().toJson(instance.id),
      'name': const RobustStringConverter().toJson(instance.name),
      'price': const RobustDoubleConverter().toJson(instance.price),
      'currency': const RobustStringConverter().toJson(instance.currency),
      'imageUrl': const RobustStringConverter().toJson(instance.imageUrl),
      'location': const RobustStringConverter().toJson(instance.location),
    };

import 'dart:math';

import 'package:enm/features/products/data/models/product_model.dart';

/// Datasource que simula un backend inconsistente
class ProductsRemoteDatasource {
  final _random = Random();
  
  // Simulamos latencia de red
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(Duration(milliseconds: 500 + _random.nextInt(1000)));
  }

  // Base de productos "estable"
  final List<ProductModel> _baseProducts = [
    const ProductModel(
      id: 'prod-001',
      name: 'Excavadora Hidráulica CAT 320',
      price: 125000,
      currency: 'USD',
      imageUrl: 'https://static.unimaq.com.pe/fcsaprdunimaq01/2019/06/0011_320_fondo.png',
      location: 'Santiago, Chile',
    ),
    const ProductModel(
      id: 'prod-002',
      name: 'Grúa Torre Liebherr 630',
      price: 450000,
      currency: 'USD',
      imageUrl: 'https://www.lectura-specs.es/models/renamed/orig/gruas-torre-con-rotacion-superior-630-ec-h-40--liebherr(4).jpg',
      location: 'Valparaíso, Chile',
    ),
    const ProductModel(
      id: 'prod-003',
      name: 'Bulldozer Komatsu D65',
      price: 180000,
      currency: 'USD',
      imageUrl: 'https://khsamgwebpro.blob.core.windows.net/wp-content/uploads/sites/3/2020/05/21153329/d65-4.jpg',
      location: 'Concepción, Chile',
    ),
    const ProductModel(
      id: 'prod-004',
      name: 'Retroexcavadora JCB 3CX',
      price: 75000,
      currency: 'USD',
      imageUrl: 'https://www.automekano.com/static/9ad38b42a38babc97204b8e294a7d129/25765/Mejora%20continua%20al%20estilo%20ingl%C3%A9s%20-%20JCB%203CX-b380d9b4.webp',
      location: 'La Serena, Chile',
    ),
    const ProductModel(
      id: 'prod-005',
      name: 'Camión Volquete Volvo FMX',
      price: 95000,
      currency: 'USD',
      imageUrl: 'https://pvrental.cl/wp-content/uploads/2025/03/20190822_114635.jpg',
      location: 'Antofagasta, Chile',
    ),
  ];

  // IDs de productos que "desaparecerán" en el detalle
  final Set<String> _missingProductIds = {};
  
  // Precios modificados para simular cambios
  final Map<String, double> _modifiedPrices = {};

  /// Simula comportamiento inconsistente del backend
  /// 
  /// Escenarios:
  /// - 20% probabilidad de retornar lista parcialmente vacía
  /// - Puede retornar productos con precios modificados
  Future<List<ProductModel>> getProducts() async {
    await _simulateNetworkDelay();

    // Simular fallo ocasional (5% de probabilidad)
    if (_random.nextInt(100) < 5) {
      throw Exception('Error de red al obtener productos');
    }

    // 20% de probabilidad de retornar lista parcial
    if (_random.nextInt(100) < 20) {
      final partialCount = 2 + _random.nextInt(3); // 2-4 productos
      return _baseProducts.sublist(0, partialCount);
    }

    // 30% de probabilidad de modificar un precio
    if (_random.nextInt(100) < 30 && _baseProducts.isNotEmpty) {
      final productToModify = _baseProducts[_random.nextInt(_baseProducts.length)];
      final priceVariation = 0.9 + _random.nextDouble() * 0.2; // ±10%
      _modifiedPrices[productToModify.id] = productToModify.price * priceVariation;
    }

    // Aplicar precios modificados
    return _baseProducts.map((product) {
      if (_modifiedPrices.containsKey(product.id)) {
        return product.copyWith(price: _modifiedPrices[product.id]!);
      }
      return product;
    }).toList();
  }

  /// Obtener detalle de un producto
  /// 
  /// Escenarios:
  /// - Productos marcados como "missing" lanzan 404
  /// - 15% probabilidad de marcar un producto como missing
  /// - Puede retornar precios diferentes al listado
  Future<ProductModel> getProductDetail(String productId) async {
    await _simulateNetworkDelay();

    // Si el producto fue marcado como "missing", simular 404
    if (_missingProductIds.contains(productId)) {
      throw ProductNotFoundException(productId);
    }

    // 15% de probabilidad de marcar como missing en este momento
    if (_random.nextInt(100) < 15) {
      _missingProductIds.add(productId);
      throw ProductNotFoundException(productId);
    }

    // Buscar producto
    final product = _baseProducts.firstWhere(
      (p) => p.id == productId,
      orElse: () => throw ProductNotFoundException(productId),
    );

    // 25% probabilidad de retornar con precio modificado
    if (_random.nextInt(100) < 25) {
      final priceVariation = 0.85 + _random.nextDouble() * 0.3; // ±15%
      return product.copyWith(price: product.price * priceVariation);
    }

    return product;
  }

  /// Simular que el backend se "recuperó" (para testing)
  void resetInconsistencies() {
    _missingProductIds.clear();
    _modifiedPrices.clear();
  }
}

/// Exception personalizada para productos no encontrados
class ProductNotFoundException implements Exception {
  final String productId;
  
  ProductNotFoundException(this.productId);
  
  @override
  String toString() => 'Producto $productId no encontrado';
}
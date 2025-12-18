import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:enm/features/products/data/repositories/products_repository_impl.dart';
import 'package:enm/features/products/data/datasources/products_remote_datasource.dart';
import 'package:enm/features/products/data/models/product_model.dart';

// Generar Mock para el Datasource
@GenerateMocks([ProductsRemoteDatasource])
import 'products_repository_test.mocks.dart';

void main() {
  late ProductsRepositoryImpl repository;
  late MockProductsRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockProductsRemoteDatasource();
    repository = ProductsRepositoryImpl(mockDatasource);
  });

  const tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    price: 100,
    currency: 'USD',
    imageUrl: 'url',
    location: 'loc',
  );

  test('should return list of Products when datasource call is successful', () async {
    // Arrange
    when(mockDatasource.getProducts()).thenAnswer((_) async => [tProductModel]);

    // Act
    final result = await repository.getProducts();

    // Assert
    expect(result.length, 1);
    expect(result.first.id, tProductModel.id);
    verify(mockDatasource.getProducts());
  });

  test('should throw exception when datasource fails', () async {
    // Arrange
    when(mockDatasource.getProducts()).thenThrow(Exception());

    // Act & Assert
    expect(() => repository.getProducts(), throwsException);
  });
}

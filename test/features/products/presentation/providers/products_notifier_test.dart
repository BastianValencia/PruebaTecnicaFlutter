import 'package:enm/core/errors/failures.dart';
import 'package:enm/features/products/domain/entities/product.dart';
import 'package:enm/features/products/domain/repositories/products_repository.dart';
import 'package:enm/features/products/presentation/providers/products_provider.dart';
import 'package:enm/features/products/presentation/states/products_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_notifier_test.mocks.dart';

@GenerateMocks([ProductsRepository])
void main() {
  late MockProductsRepository mockRepository;
  
  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        productsRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() {
    mockRepository = MockProductsRepository();
  });

  const tProduct = Product(
    id: '1',
    name: 'Test Product',
    price: 100.0,
    currency: 'USD',
    imageUrl: 'url',
    location: 'loc',
  );

  group('ProductsNotifier', () {
    test('initial state should be loading (isRefreshing: true)', () {
      final container = createContainer();
      final sub = container.listen(productsProvider, (_, __) {});
      
      final ProductsState state = sub.read();
      expect(state.isRefreshing, true);
    });

    test('loadProducts success should update state with products', () async {
      when(mockRepository.getProducts()).thenAnswer((_) async => [tProduct]);
      
      final container = createContainer();
      final sub = container.listen(productsProvider, (_, __) {});
      
      await container.read(productsProvider.notifier).loadProducts();
      
      final ProductsState state = sub.read();
      expect(state.isRefreshing, false);
      expect(state.products, [tProduct]);
      expect(state.error, null);
    });

    test('loadProducts failure should update state with error', () async {
      when(mockRepository.getProducts()).thenThrow(const ServerFailure('Error fetching'));
      
      final container = createContainer();
      final sub = container.listen(productsProvider, (_, __) {});
      
      await container.read(productsProvider.notifier).loadProducts();
      
      final ProductsState state = sub.read();
      expect(state.isRefreshing, false);
      expect(state.products, isEmpty);
      expect(state.error, contains('Error fetching'));
    });
  });
}

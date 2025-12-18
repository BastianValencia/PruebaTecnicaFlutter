import 'package:enm/features/products/domain/entities/product.dart';
import 'package:enm/features/products/domain/repositories/products_repository.dart';
import 'package:enm/features/products/presentation/providers/products_provider.dart';
import 'package:enm/features/products/presentation/screens/products_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart'; // We might need this or just mock image provider, but let's try standard offline first

import 'package:sizer/sizer.dart';

import 'products_list_screen_test.mocks.dart';

@GenerateMocks([ProductsRepository])
void main() {
  late MockProductsRepository mockRepo;

  setUp(() {
    mockRepo = MockProductsRepository();
  });

  const testProduct = Product(
    id: '1',
    name: 'Test Product',
    price: 1000,
    currency: 'USD',
    imageUrl: 'https://example.com/image.png',
    location: 'Test Loc',
  );

  testWidgets('ProductsListScreen shows loading and then products', (tester) async {
    // 1. Stub the repository
    when(mockRepo.getProducts()).thenAnswer((_) async {
      await Future.delayed(const Duration(milliseconds: 100)); // Simulate delay
      return [testProduct];
    });

    // 2. Build UI with Riverpod overrides
    // We use mockNetworkImagesFor to avoid HTTP errors with Image.network
    await mockNetworkImagesFor(() => tester.pumpWidget(
      ProviderScope(
        overrides: [
          productsRepositoryProvider.overrideWithValue(mockRepo),
        ],
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return const MaterialApp(
              home: ProductsListScreen(),
            );
          },
        ),
      ),
    ));

    // 3. Verify loading state
    // Initial build might show loader immediately if we trigger load
    // But ProductsNotifier loads on Init? Yes usually init() calls load logic?
    // Let's check provider code. If it uses AsyncValue it might start loading.
    
    // Check loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // 4. Wait for data
    await tester.pump(const Duration(milliseconds: 500)); // Finish delay
    await tester.pumpAndSettle(); // Animations

    // 5. Verify data
    expect(find.text('Test Product'), findsOneWidget);
    // expect(find.text('120'), findsOneWidget); // Rating hardcoded - Removed in new design
  });
}

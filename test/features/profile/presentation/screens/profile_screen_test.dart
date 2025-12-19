import 'package:enm/features/profile/domain/entities/user.dart';
import 'package:enm/features/profile/domain/entities/user_role.dart';
import 'package:enm/features/profile/domain/repositories/profile_repository.dart';
import 'package:enm/features/profile/presentation/providers/profile_provider.dart';
import 'package:enm/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:sizer/sizer.dart';

import 'profile_screen_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late MockProfileRepository mockRepository;

  setUp(() {
    mockRepository = MockProfileRepository();
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        profileRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return const MaterialApp(
            home: ProfileScreen(),
          );
        },
      ),
    );
  }

  const tUser = User(
    id: '123',
    name: 'Test User',
    email: 'test@email.com',
    role: UserRole.buyer,
  );

  group('ProfileScreen', () {
    testWidgets('should render user name and email when data is loaded', (tester) async {
       when(mockRepository.getUser()).thenAnswer((_) async => tUser);

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(createWidgetUnderTest());
          await tester.pumpAndSettle(); // Wait for AsyncValue to resolve

          expect(find.text('Test User'), findsOneWidget);
          expect(find.text('test@email.com'), findsOneWidget);
          expect(find.text('Comprador'), findsOneWidget);
        });
    });

    testWidgets('should find theme toggle switch', (tester) async {
        when(mockRepository.getUser()).thenAnswer((_) async => tUser);

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(createWidgetUnderTest());
          await tester.pumpAndSettle();

          expect(find.byType(Switch), findsOneWidget);
        });
    });
  });
}

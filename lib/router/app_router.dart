import 'package:go_router/go_router.dart';

import 'package:enm/features/products/presentation/screens/product_detail_screen.dart';
import 'package:enm/features/products/presentation/screens/products_list_screen.dart';
import 'package:enm/features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/profile_edit_screen.dart';
import 'scaffold_with_nav.dart';

final goRouter = GoRouter(
  initialLocation: '/products',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNav(child: child);
      },
      routes: [
        GoRoute(
          path: '/products',
          name: 'products',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProductsListScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),
    // Rutas fuera del bottom nav
    GoRoute(
      path: '/product/:id',
      name: 'product-detail',
      builder: (context, state) {
        final productId = state.pathParameters['id']!;
        return ProductDetailScreen(productId: productId);
      },
    ),
    GoRoute(
      path: '/profile/edit',
      name: 'profile-edit',
      builder: (context, state) => const ProfileEditScreen(),
    ),
  ],
);
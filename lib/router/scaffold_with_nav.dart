import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNav({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: colors.surface,
          selectedItemColor: colors.onSurface,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          currentIndex: _calculateSelectedIndex(context),
          onTap: (index) => _onItemTapped(index, context),
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.home_filled),
              ),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                 padding: EdgeInsets.only(bottom: 4),
                 child: Icon(Icons.person_outline),
              ),
              activeIcon: Padding(
                 padding: EdgeInsets.only(bottom: 4),
                 child: Icon(Icons.person),
              ),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/products')) return 0;
    if (location.startsWith('/profile')) return 1;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/products');
        break;
      case 1:
        context.go('/profile');
        break;
    }
  }
}
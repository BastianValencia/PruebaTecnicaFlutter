import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:enm/shared/theme/app_theme.dart';
import 'package:enm/shared/theme/theme_provider.dart';
import 'router/app_router.dart';

import 'package:sizer/sizer.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          title: 'Marketplace App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          routerConfig: goRouter,
        );
      },
    );
  }
}
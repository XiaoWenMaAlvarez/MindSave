import 'package:flutter/material.dart';
import 'package:mindsave/config/router/app_router.dart';
import 'package:mindsave/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/home/presentation/providers/providers.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.read(themeProvider.notifier).getDarkModeFromLocalStorage();

    final AppTheme appTheme = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Mind Save',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: appTheme.getTheme(),
    );
  }
}

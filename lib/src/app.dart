import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRoute = ref.watch(goRouteProvider);

    final app =  MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRoute,
      themeMode: ThemeMode.light,
      themeAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOutCubic,
        reverseCurve: Curves.easeInOutCubic,
      ),
      themeAnimationCurve: Curves.easeInOutCubic,
      themeAnimationDuration: const Duration(milliseconds: 200),
      // builder: MainBuilder.build,
    );

    return app;
  }
}

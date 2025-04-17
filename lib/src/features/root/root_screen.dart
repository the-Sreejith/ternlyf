import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/controller/profile_controller.dart';

import '../home/presentation/home_screen.dart';
import '../onboarding/onboarding_screen.dart';

import 'provider/root_provider.dart';

/// Switches between Auth & non-auth state
class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializationState = ref.watch(rootProvider);

    return initializationState.maybeWhen(
      data: (_) {
        final user = ref.watch(sessionController);
        final isLoggedIn = user != null;
        return isLoggedIn ? const HomeScreen() : const OnboardingScreen();
      },
      orElse: () {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

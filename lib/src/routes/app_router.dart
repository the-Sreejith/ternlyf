import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/otp_verification_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/profile_creation/presentation/user_profile_form_screen.dart';
import '../features/root/root_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/presentation/login_screen.dart';

import 'routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

// final _shellNavigatorKey = GlobalKey<NavigatorState>();
final goRouteProvider = Provider<GoRouter>((ref) {

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    observers: <NavigatorObserver>[],
    routes: <RouteBase>[
      GoRoute(
        name: Routes.initialRoute,
        path: '/',
        builder: (context, state) => const RootScreen(),
      ),
      GoRoute(
        path: Routes.OnboardingScreenRoute,
        name: Routes.OnboardingScreenRoute,
        builder: (context, state) => OnboardingScreen(),
        routes: [
          GoRoute(
            path: Routes.LoginScreenRoute,
            name: Routes.LoginScreenRoute,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: Routes.OTPVerificationScreenRoute,
            name: Routes.OTPVerificationScreenRoute,
            builder: (context, state) => const OtpVerificationScreen(),
          )
        ],
      ),
      GoRoute(
        path: Routes.HomeScreenRoute,
        name: Routes.HomeScreenRoute,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: Routes.ProfileSetUpScreenRoute,
        name: Routes.ProfileSetUpScreenRoute,
        builder: (context, state) => UserProfileFormScreen(),
      )
      // GoRoute(
      //   name: Routes.NotificationPermissionScreenRoute,
      //   path: Routes.NotificationPermissionScreenRoute,
      //   builder: (BuildContext context, GoRouterState state) => const NotificationPermissionScreen(),
      // ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      return null;
    },
  );
});

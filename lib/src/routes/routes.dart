// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

@immutable
class Routes {
  const Routes._();
  static const String initialRoute = AppRootScreenRoute;
  static const String AppRootScreenRoute = 'app-root-screen';
  static const String OnboardingScreenRoute = '/onboarding-screen';
  static const String LoginScreenRoute = '/login-screen';
  static const String OTPVerificationScreenRoute = '/otp-verification';
  static const String HomeScreenRoute = '/Home-screen';
}

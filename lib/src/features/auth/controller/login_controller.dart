import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/superbase_sign_in_repo.dart';
import 'session_controller.dart';

final loginController =
    StateNotifierProvider<LoginController, AsyncValue<void>>(
  (ref) => LoginController(ref),
);

// Provider to store phone number during OTP flow
final phoneNumberProvider = StateProvider<String>((ref) => '');

class LoginController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  LoginController(this.ref) : super(const AsyncData(null));

  SessionController get session => ref.read(sessionController.notifier);

  Future<void> requestPhoneOtp(String phone) async {
    state = const AsyncLoading();

    try {
      await ref.read(superbaseSignInRepoProvider).requestPhoneOtp(
            phone: phone,
          );
      // Store the phone number for verification step
      ref.read(phoneNumberProvider.notifier).state = phone;
      state = const AsyncData(null);
    } on AuthException catch (e, st) {
      log('error ${e.message}');
      state = AsyncError(e.message, st);
    }
  }

  Future<void> verifyPhoneOtp(String otpCode) async {
    state = const AsyncLoading();
    try {
      final phone = ref.read(phoneNumberProvider);
      await ref.read(superbaseSignInRepoProvider).verifyPhoneOtp(
            phone: phone,
            otpCode: otpCode,
          );
      await session.init();
      state = const AsyncData(null);
    } on AuthException catch (e, st) {
      state = AsyncError(e.message, st);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    try {
      await ref.read(superbaseSignInRepoProvider).googleSignIn();
      await session.init();
      state = const AsyncData(null);
    } on AuthException catch (e, st) {
      log(e.message);
      state = AsyncError(e.message, st);
    }
  }
}
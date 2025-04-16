import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SuperBaseSignInRepo {
  Future<void> signInWithPhone({
    required String phone,
    required String otpCode,
  });
  Future<void> verifyPhoneOtp({
    required String phone,
    required String otpCode,
  });
  Future<void> requestPhoneOtp({
    required String phone,
  });
  Future<void> signOut();
  Future<User?> checkUserSession();
  Future<void> deleteUser();
  Future<void> googleSignIn();
}

final superbaseSignInRepoProvider = Provider<SuperBaseSignInRepo>((ref) {
  return SuperBaseSignInRepoImpl();
});

class SuperBaseSignInRepoImpl implements SuperBaseSignInRepo {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<User?> checkUserSession() async {
    return _supabase.auth.currentUser;
  }

  @override
  Future<void> signInWithPhone({
    required String phone,
    required String otpCode,
  }) async {
    await _supabase.auth.verifyOTP(
      phone: phone,
      token: otpCode,
      type: OtpType.sms,
    );
  }

  @override
  Future<void> requestPhoneOtp({
    required String phone,
  }) async {
    await _supabase.auth.signInWithOtp(
      phone: phone,
    );
  }

  @override
  Future<void> verifyPhoneOtp({
    required String phone,
    required String otpCode,
  }) async {
    await _supabase.auth.verifyOTP(
      phone: phone,
      token: otpCode,
      type: OtpType.sms,
    );
  }

  @override
  Future<void> googleSignIn() async {
    log("Google sign-In clicked");
    // await _supabase.auth.signInWithOAuth(
    //   Provider.google,
    //   redirectTo: 'your-app-scheme://login-callback',
    // );
  }

  @override
  Future<void> deleteUser() async {
    await _supabase.auth.admin.deleteUser(_supabase.auth.currentUser!.id);
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
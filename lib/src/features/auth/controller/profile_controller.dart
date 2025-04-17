import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/superbase_sign_in_repo.dart';

class SessionController extends StateNotifier<User?> {
  final Ref ref;
  SessionController(this.ref) : super(null);

  bool get isLoggedIn => state != null;

  /// Check if a user is already signed in
  Future<void> init() async {
    state = await ref.read(superbaseSignInRepoProvider).checkUserSession();
  }

  /// Sign out
  Future<void> signOut() async {
    ref.read(superbaseSignInRepoProvider).signOut();
    state = null;
  }

  /// Delete User
  Future<void> deleteUser() async {
    ref.read(superbaseSignInRepoProvider).deleteUser();
    state = null;
  }

}

/// Riverpod Provider for SessionController
final sessionController =
    StateNotifierProvider<SessionController, User?>(
      (ref) => SessionController(ref),
    );
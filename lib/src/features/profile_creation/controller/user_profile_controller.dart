import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ternlyf/src/features/profile_creation/data/user_profile_repo.dart';

import '../../auth/controller/session_controller.dart';

final userProfileController = StateNotifierProvider<UserProfileController, AsyncValue<void>>(
  (ref) => UserProfileController(ref),
);

class UserProfileController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  UserProfileController(this.ref) : super(const AsyncData(null));

  Future<void> createUserProfile({
    required String name,
    required DateTime dob,
    required String gender,
  }) async {
    state = const AsyncLoading();

    try {
      final session = ref.read(sessionController);  // from your auth feature
      if (session == null) throw Exception("User not logged in.");

      await ref.read(userProfileRepoProvider).createUserProfile(
        userId: session.id,
        name: name,
        dob: dob,
        gender: gender,
      );

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

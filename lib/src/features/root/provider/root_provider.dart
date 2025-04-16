import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/profile_controller.dart';

/// Ensures that [profileController] has been initialized
final rootProvider = FutureProvider<bool>((ref) async {
  await ref.read(profileController.notifier).init();
  return true;
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controller/profile_controller.dart';

/// Ensures that [sessionController] has been initialized
final rootProvider = FutureProvider<bool>((ref) async {
  await ref.read(sessionController.notifier).init();
  return true;
});

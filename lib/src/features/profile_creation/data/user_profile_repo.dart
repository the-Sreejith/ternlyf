import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userProfileRepoProvider = Provider<UserProfileRepo>((ref) => UserProfileRepo());

class UserProfileRepo {
  final _client = Supabase.instance.client;

  Future<void> createUserProfile({
    required String userId,
    required String name,
    required DateTime dob,
    required String gender,
  }) async {
    await _client.from('user_profiles').insert({
      'id': userId,
      'name': name,
      'dob': dob.toIso8601String(),
      'gender': gender,
    });
  }
}

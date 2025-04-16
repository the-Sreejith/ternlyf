import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app.dart';

Future<void> bootstrap() async {
  await Supabase.initialize(
    url: 'https://kdhvopjfldedueruaods.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkaHZvcGpmbGRlZHVlcnVhb2RzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ3MzM1NzMsImV4cCI6MjA2MDMwOTU3M30.EMAoOTZQPCqIhi2HJdkx-VSxv_mLghonnL6Ffj4546I',
  );

  runApp(ProviderScope(child: const App()));
}

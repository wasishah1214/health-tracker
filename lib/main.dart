import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/activity_provider.dart';
import 'providers/challenge_provider.dart';
import 'providers/carbon_offset_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ActivityProvider()),
        // ChangeNotifierProvider(create: (_) {
        //   final provider = ActivityProvider();
        //   provider.addSampleActivities(); // Add sample data
        //   return provider;
        // }),
        ChangeNotifierProvider(create: (_) => ChallengeProvider()),
        ChangeNotifierProvider(create: (_) => CarbonOffsetProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/challenges_screen.dart';
import 'screens/carbon_offset_screen.dart';
import 'screens/progress_screen.dart' as progress;
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'providers/auth_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// push..
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Fitness Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (auth.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return auth.isAuthenticated ? HomeScreen() : const LoginScreen();
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/activity': (context) => ActivityScreen(),
        '/challenges': (context) => const ChallengesScreen(),
        '/carbon-offset': (context) => const CarbonOffsetScreen(),
        '/progress': (context) => const progress.ProgressScreen(),
      },
    );
  }
}
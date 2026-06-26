import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/dashboard/providers/vfd_provider.dart';
import '../presentation/dashboard/screens/dashboard_screen.dart';
import '../presentation/splash/screens/splash_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'FRENIC-MEGA Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF16161F),
      ),
      home: const SplashScreen(),
    );
  }
}

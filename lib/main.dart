import 'package:courtly_vendor/core/config/app_themes.dart';
import 'package:courtly_vendor/presentation/pages/login.dart';
import 'package:flutter/material.dart';

/// [main] is the entry point of the application.
/// This function runs the application.
///
/// - Returns: void
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/// [MyApp] is the main application widget.
/// This widget is the root of the application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courtly Vendor',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      home: LoginPage(),
    );
  }
}

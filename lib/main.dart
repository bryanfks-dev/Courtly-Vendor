import 'package:courtly_vendor/core/config/app_themes.dart';
import 'package:courtly_vendor/presentation/pages/change_password.dart';
import 'package:courtly_vendor/presentation/pages/my_court_detail.dart';
import 'package:courtly_vendor/presentation/pages/login.dart';
import 'package:courtly_vendor/presentation/pages/my_courts.dart';
import 'package:courtly_vendor/presentation/widgets/app_scaffold.dart';
import 'package:courtly_vendor/routes/routes.dart';
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
  /// [_currentIndex] is the current index of the page.
  int _currentIndex = 1;

  /// [_setLoginPage] is a function to set the login page.
  /// This function sets the current index to 0.
  ///
  /// Returns: void
  void _setLoginPage() {
    setState(() {
      _currentIndex = 0;
    });
  }

  /// [_setAppScaffoldPage] is a function to set the app scaffold page.
  /// This function sets the current index to 1.
  ///
  /// Returns: void
  void _setAppScaffoldPage() {
    setState(() {
      _currentIndex = 1;
    });
  }

  /// [_pages] is the list of pages in the application.
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Initialize the pages
    _pages = [
      LoginPage(
        toAppScaffoldPage: _setAppScaffoldPage,
      ),
      const AppScaffold()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courtly Vendor',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      routes: {
        Routes.myCourts: (context) => MyCourtsPage(),
        Routes.detailCourts: (context) => const MyCourtDetail(),
        Routes.changePassword: (context) => const ChangePasswordPage(),
      },
      home: _pages[_currentIndex],
    );
  }
}

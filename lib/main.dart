import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/splash_screen.dart';
import 'constants/app_colors.dart';
import 'services/user_session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSession.loadUser();

  final prefs = await SharedPreferences.getInstance();
  final bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(
    GroceryApp(
      isDarkMode: isDarkMode,
    ),
  );
}

class GroceryApp extends StatefulWidget {
  final bool isDarkMode;

  const GroceryApp({
    super.key,
    required this.isDarkMode,
  });

  static final ValueNotifier<bool> darkModeNotifier =
  ValueNotifier<bool>(false);

  static Future<void> changeTheme(bool value) async {
    darkModeNotifier.value = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  @override
  State<GroceryApp> createState() => _GroceryAppState();
}

class _GroceryAppState extends State<GroceryApp> {
  @override
  void initState() {
    super.initState();

    GroceryApp.darkModeNotifier.value = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GroceryApp.darkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          title: 'Grocery App',
          debugShowCheckedModeBanner: false,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

          // Light Mode Theme
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF7FBF8),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryGreen,
              brightness: Brightness.light,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFF7FBF8),
              foregroundColor: AppColors.textDark,
              elevation: 0,
              centerTitle: true,
            ),
            fontFamily: 'Roboto',
          ),

          // Dark Mode Theme
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF101820),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryGreen,
              brightness: Brightness.dark,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF101820),
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            cardColor: const Color(0xFF1B2733),
            fontFamily: 'Roboto',
          ),

          home: const SplashScreen(),
        );
      },
    );
  }
}
// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Adda/pages/splash_screen.dart';
import './pages/theme_provider.dart';
import './pages/app_theme.dart'; // Import the AppTheme class
import 'package:flutter_contacts/flutter_contacts.dart';

Future<List<Contact>> getContacts() async {
  return await FlutterContacts.getContacts(withThumbnail: false);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterContacts.requestPermission();
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Adda',
          theme: themeProvider.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}
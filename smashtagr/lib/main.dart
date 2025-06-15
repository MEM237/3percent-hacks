

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'pages/dashboard_page.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style for steel aesthetic
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF1A1A1A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const SteelViewApp());
}

class SteelViewApp extends StatelessWidget {
  const SteelViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SteelView dApp',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const DashboardPage(),
    );
  }
}
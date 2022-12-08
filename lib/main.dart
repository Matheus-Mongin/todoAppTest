import 'package:flutter/material.dart';

import 'Views/home_page_view/home_page_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const iconTheme = IconThemeData(color: Colors.blue);
    return MaterialApp(
      home: HomePageView(),
      theme: ThemeData(
        primaryIconTheme: iconTheme,
        backgroundColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(
          iconTheme: iconTheme,
          actionsIconTheme: iconTheme,
          backgroundColor: Color(0xFFFFFFFF),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      ),
    );
  }
}

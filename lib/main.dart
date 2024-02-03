import "package:flutter/material.dart";

import "screens/home_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const HomePage(),
    );
  }
}

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 34, 40, 49),
  background: const Color.fromARGB(255, 57, 62, 70),
  primary: const Color.fromARGB(255, 0, 173, 181),
  secondary: const Color.fromARGB(255, 238, 238, 238),
);

final theme = ThemeData().copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.background,
    textTheme: const TextTheme().apply(
      bodyColor: colorScheme.primary,
    ));

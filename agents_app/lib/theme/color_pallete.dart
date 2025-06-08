import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF90CAF9),          // Azul pastel
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFE3F2FD), // Fondo claro
    secondary: Color(0xFFA5D6A7),        // Verde menta
    onSecondary: Colors.black,
    //background: Color(0xFFF5FAFF),       // Fondo global
    //onBackground: Color(0xFF212121),
    surface: Colors.white,
    onSurface: Color(0xFF212121),
    error: Color(0xFFFFAB91),            // Coral
    onError: Colors.white,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xFFF5FAFF),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF90CAF9),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: Color(0xFF212121)),
    bodyMedium: TextStyle(color: Color(0xFF616161)),
  ),
);

import 'package:flutter/material.dart';

//https://coolors.co/palette/d9ed92-b5e48c-99d98c-76c893-52b69a-34a0a4-168aad-1a759f-1e6091-184e77

final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF184E77),
    primaryFixed: Color(0xFF1A759F),
    onPrimary: Color(0xFF1E6091),
    primaryContainer: Color(0xFF2b8dcc),
    onPrimaryFixed: Color(0xFF76C893),
    secondary: Color(0xFF1E6091),
    onSecondary: Colors.black,
    //background: Color(0xFFF5FAFF),
    //onBackground: Color(0xFF212121),
    onSecondaryFixed: Color(0xFFF2F8FD), //BASE 184E77
    onSecondaryFixedVariant: Color(0xFFE4EFFA), //BASE 184E77
    surfaceContainerHighest: Color(0xFF1E6091),
    surface: Colors.white,
    onSurface: Color(0xFF1f2421),
    error: Color(0xFFd62828),
    onError: Color(0xFFe63946),  //ae2012 alternative
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xFFF5FAFF),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF184E77),
    foregroundColor: Color(0xFFd4f3f1),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: Color(0xFF212121)),
    bodyMedium: TextStyle(color: Color(0xFF616161)),
  ),
);

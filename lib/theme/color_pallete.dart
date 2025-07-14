import 'package:flutter/material.dart';

//https://coolors.co/palette/d9ed92-b5e48c-99d98c-76c893-52b69a-34a0a4-168aad-1a759f-1e6091-184e77

// darkPastelTheme
final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,

    primary: Color(
        0xFF2E3A59), // Color principal: botones primarios, AppBar, íconos activos
    onPrimary: Color(0xFFF0F0F0), // Texto o íconos sobre el color primario

    secondary: Color(
        0xFFF2B5D4), // Color complementario: botones secundarios, etiquetas o acentos
    onSecondary: Color(0xFF1A1C1E), // Texto sobre el color secundario

    background: Color(0xFF1A1C1E), // Fondo general de la aplicación
    onBackground: Color(0xFFF0F0F0), // Texto principal sobre el fondo

    surface:
        Color(0xFF2C2E33), // Fondo de superficies como tarjetas, paneles, menús
    onSurface: Color(0xFFF0F0F0), // Texto o íconos sobre las superficies

    error: Color(0xFFD77A61), // Colores de error o advertencia
    onError: Color(0xFFFFFFFF), // Texto sobre el color de error
  ),

  scaffoldBackgroundColor:
      const Color(0xFF1A1C1E), // Fondo del Scaffold (pantalla principal)

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2E3A59), // Color de fondo del AppBar
    foregroundColor:
        Color(0xFFF0F0F0), // Color del texto y los íconos en el AppBar
    elevation: 0,
  ),

  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: Color(0xFFF0F0F0)), // Títulos principales
    bodyMedium:
        TextStyle(color: Color(0xFFA1A1AA)), // Texto secundario o de cuerpo
  ),

  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2E3A59), // Fondo del botón
      foregroundColor: const Color(0xFFF0F0F0), // Texto e íconos en blanco
      textStyle: const TextStyle(
        fontSize: 16,
        // fontWeight: FontWeight.w500,
        color: Color(0xFFF0F0F0), // Texto del botón
      ),
    ),
  ),
);



// final ThemeData appTheme = ThemeData(
//   colorScheme: ColorScheme(
//     brightness: Brightness.light,
//     primary: Color(0xFF184E77),
//     primaryFixed: Color(0xFF1A759F),
//     onPrimary: Color(0xFF1E6091),
//     primaryContainer: Color(0xFF2b8dcc),
//     onPrimaryFixed: Color(0xFF76C893),
//     secondary: Color(0xFF34A0A4),
//     onSecondary: Colors.black,
//     // onSurfaceVariant: Colors.grey[200],
//     //background: Color(0xFFF5FAFF),
//     //onBackground: Color(0xFF212121),
//     onSecondaryFixed: Color(0xFFF2F8FD), //BASE 184E77
//     onSecondaryFixedVariant: Color(0xFFE4EFFA), //BASE 184E77
//     surfaceContainerHighest: Color(0xFF1E6091),
//     surface: Colors.white,
//     onSurface: Color(0xFF1f2421),
//     onTertiaryContainer: Colors.grey[200],
//     error: Color(0xFFd62828),
//     onError: Color(0xFFe63946), //ae2012 alternative
//   ),
//   useMaterial3: true,
//   scaffoldBackgroundColor: Color(0xFFF5FAFF),
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFF184E77),
//     foregroundColor: Color(0xFFd4f3f1),
//     elevation: 0,
//   ),
//   textTheme: const TextTheme(
//     headlineSmall: TextStyle(color: Color(0xFF212121)),
//     bodyMedium: TextStyle(color: Color(0xFF616161)),
//   ),
// );


// final ThemeData appTheme = ThemeData(
//   colorScheme: const ColorScheme(
//     brightness: Brightness.light,
//     primary: Color(0xFF114358),              // Color principal
//     primaryContainer: Color(0xFFF1ECE7),      // Fondo suave (segundo complementario)
//     onPrimary: Color(0xFFFFFFFF),             // Texto sobre primary
//     secondary: Color(0xFFF2AA1F),             // Color complementario (resaltado, botones, alertas)
//     onSecondary: Color(0xFF090909),           // Texto sobre secundario
//     error: Color(0xFFD62828),                 // Error
//     onError: Color(0xFFFFFFFF),
//     // background: Color(0xFFF1ECE7),            // Fondo general
//     // onBackground: Color(0xFF090909),          // Texto sobre fondo
//     surface: Colors.white,                    // Superficies como tarjetas
//     onSurface: Color(0xFF090909),             // Texto sobre superficies
//   ),
//   useMaterial3: true,
//   scaffoldBackgroundColor: const Color(0xFFF1ECE7),
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFF114358),
//     foregroundColor: Colors.white,
//     elevation: 0,
//   ),
//   textTheme: const TextTheme(
//     headlineSmall: TextStyle(color: Color(0xFF090909)),
//     bodyMedium: TextStyle(color: Color(0xFF333333)),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Color(0xFFF2AA1F), // Botones resaltados
//       foregroundColor: Color(0xFF090909),
//     ),
//   ),
// );


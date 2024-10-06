import 'package:flutter/material.dart';
ThemeData getThemeConfig(){
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF9E1111),
      // primary: const Color(0xFF3E7CB1),
    ),
    scaffoldBackgroundColor: Color(0xffF2F2F2),

    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF9E1111),
      foregroundColor: const Color(0xff3B3B41),
      titleTextStyle: TextStyle(
        color: const Color(0xffF2F2F2), // Color del texto del título
        fontSize: 20, // Tamaño de la fuente del título
        fontWeight: FontWeight.bold, // Peso de la fuente del título
      ),
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFF9E1111),
      textTheme: ButtonTextTheme.primary,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF9E1111),
    ),

    iconTheme: IconThemeData(
      color: const Color(0xFF9E1111),
    ),

    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
      borderSide: BorderSide(color: const Color(0xFF9E1111)),
    )),

  );
}

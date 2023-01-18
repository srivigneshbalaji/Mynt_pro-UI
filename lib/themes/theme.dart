import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    fontFamily: 'Rajdhani',
    primaryColor: Colors.white,
    primarySwatch: Colors.blue,
    colorScheme: const ColorScheme.dark()
        .copyWith(primary: Colors.white, secondary: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.black,
    ),
    inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Colors.blue),
    )),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black, foregroundColor: Colors.white),
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'Rajdhani',
    primaryColor: Colors.black,
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      foregroundColor: Colors.black,
    ),
    inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Colors.blue),
    )),
    colorScheme: const ColorScheme.light()
        .copyWith(primary: Colors.black, secondary: Colors.black),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
    iconTheme: const IconThemeData(color: Colors.black),
    dialogTheme: const DialogTheme(backgroundColor: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white, foregroundColor: Colors.black),
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Colors.black,
    ),
  );
}

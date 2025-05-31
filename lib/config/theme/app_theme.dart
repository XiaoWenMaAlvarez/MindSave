import 'package:flutter/material.dart';

class AppTheme {

  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = false
  });

  ThemeData getTheme(){
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF00B2B3),
      brightness: isDarkMode? Brightness.dark : Brightness.light,
    );
  }

  AppTheme copyWith({
    bool? isDarkMode
  }){
    return AppTheme(
      isDarkMode: isDarkMode ?? this.isDarkMode
    );
  }

}

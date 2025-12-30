import 'package:flutter/material.dart';
import 'package:hux/hux.dart';

final customLightTheme = HuxTheme.lightTheme.copyWith(
  scaffoldBackgroundColor: const Color(0xffFAFDFF),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xffFAFDFF),
  ),
);

final customDarkTheme = HuxTheme.darkTheme.copyWith(
  scaffoldBackgroundColor: const Color(0xFF1C1F23),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1C1F23),
  ),
);

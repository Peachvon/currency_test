import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeCustom {
  static const Color mainColor = Color.fromRGBO(244, 67, 54, 1);
}

ThemeData themeApp = ThemeData(
  //focusColor: Colors.amber,
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.blue.withOpacity(0.5),
    cursorColor: Colors.blue,
    selectionHandleColor: Colors.blue,
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.promptTextTheme(),
);

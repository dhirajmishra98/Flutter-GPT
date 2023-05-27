import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  // useMaterial3: true,
  // brightness: Brightness.light,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.deepOrange,
        onSecondary: Colors.white,
      ),
  scaffoldBackgroundColor: Colors.white,
);

final darkTheme = ThemeData.dark().copyWith(
  // useMaterial3: true,
  // brightness: Brightness.dark,
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
        secondary: Colors.blueGrey,
        onSecondary: Colors.white,
      ),
  scaffoldBackgroundColor: Colors.black,
);

const Color ksendorBoxBackgroundColor = Color.fromRGBO(83, 147, 241, 1);
const Color kiconsBackgroundColor = Color.fromRGBO(241, 241, 241, 1);
const Color ksenderTextColor = Colors.white;
const Color krecieverTextColor = Colors.black;

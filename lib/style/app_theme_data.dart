import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'letter_spacing.dart';

class AppThemeData {
  final BorderRadius borderRadius = BorderRadius.circular(8);

  final Color colorYellow = const Color(0xffffff00);
  final Color colorPrimary = const Color(0xffabcdef);

  ThemeData get materialTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Color(0xFF33333D),
        elevation: 0,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 0,
      ),
      tabBarTheme: null,
      scaffoldBackgroundColor: const Color(0xFF33333D),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
      outlinedButtonTheme: outlineButtonThemeData,
      textButtonTheme: textButtonThemeData,
      primaryColor: const Color(0xFF1C839E),
      secondaryHeaderColor: Colors.white,
      primaryColorDark: const Color(0xFF1C839E),
      primaryColorLight: const Color(0xFF9970A9),
      focusColor: const Color(0xCCFFFFFF),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.lightBlue[50]), // app header text
      ),
      inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.lightBlue,
            fontWeight: FontWeight.w500,
          ),
          isDense: false,
          contentPadding: EdgeInsets.all(10),
          filled: false,
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF935D5D), width: 1.0),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF935D5D), width: 1.0),
          ),
          fillColor: Color(0xFFE0E2E2),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purpleAccent, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          )),
      visualDensity: VisualDensity.standard,
      cardColor: Colors.black12,
      dialogBackgroundColor: Colors.white,
      shadowColor: Colors.grey,
    );
  }

  TextTheme _buildTextTheme(TextTheme base) {

    return base
        .apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        )
        .copyWith(
          bodyLarge: GoogleFonts.getFont('Source Sans 3',
              fontSize: 14,
              height: 1.4,
              fontWeight: FontWeight.normal,
              letterSpacing: letterSpacingOrNone(0.5),
              color: Colors.white),
          bodyMedium: GoogleFonts.getFont('Source Sans 3',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: letterSpacingOrNone(0.5),
            color: Colors.lightGreen,
          ),
          labelLarge: GoogleFonts.getFont('Source Sans 3',
            fontWeight: FontWeight.w700,
            letterSpacing: letterSpacingOrNone(2.8),
            color: Colors.lightBlue[200],
          ),
          bodySmall: GoogleFonts.getFont('Source Sans 3',
              fontSize: 14,
              height: 1.4,
              fontWeight: FontWeight.normal,
              letterSpacing: letterSpacingOrNone(0.5),
              color: Colors.white),
          displayLarge:
            GoogleFonts.getFont('Source Sans 3', color: const Color(0xFF1C839E), fontSize: 40, fontWeight: FontWeight.w100),
          displaySmall: GoogleFonts.getFont('Source Sans 3', fontSize: 24, fontWeight: FontWeight.w400),
          headlineMedium: GoogleFonts.getFont('Source Sans 3', color: Colors.lightGreenAccent),
          headlineSmall: GoogleFonts.getFont('Source Sans 3',
              fontSize: 40, fontWeight: FontWeight.w600, letterSpacing: letterSpacingOrNone(1.4), color: Colors.white),
          titleMedium: const TextStyle(color: Colors.lightGreenAccent), // input text
          titleLarge: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        );
  }

  OutlinedButtonThemeData get outlineButtonThemeData {
    return OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      minimumSize: Size.zero,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    ).copyWith(side: MaterialStateProperty.resolveWith<BorderSide?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return const BorderSide(
            color: Colors.yellow,
            width: 1,
          );
        } else {
          return const BorderSide(
            color: Color(0xFF1C839E),
            width: 1,
          );
        }
      },
    )));
  }

  TextButtonThemeData get textButtonThemeData {
    return TextButtonThemeData(
        style: OutlinedButton.styleFrom(
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    ).copyWith(side: MaterialStateProperty.resolveWith<BorderSide?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return const BorderSide(
            color: Colors.yellow,
            width: 1,
          );
        } else {
          return const BorderSide(
            color: Color(0xFF1C839E),
            width: 1,
          );
        }
      },
    )));
  }
}

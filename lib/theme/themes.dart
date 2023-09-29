import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//? LIGHT ColorScheme
const Color lightPrimaryColor = Color(0XFF1F4061);
const Color onPrimary = Colors.white;
const Color secondary = Color(0xFF1F4061);
const Color onSecondary = Colors.white;
const Color error = Colors.red;
const Color onError = Colors.white;
const Color background = Colors.white;
const Color onBackground = Color(0xFF1F4061);
const Color surface = Colors.white;
const Color onSurface = Color(0xFF1F4061);
const Color darkPrimaryColor = Color.fromARGB(255, 1, 67, 18);


const ColorScheme lightColorScheme = ColorScheme.light(
  brightness: Brightness.light,
  primary: lightPrimaryColor,
  onPrimary: onPrimary,
  secondary: secondary,
  onSecondary: onSecondary,
  error: error,
  onError: onError,
  background: background,
  onBackground: onBackground,
  surface: surface,
  onSurface: onSurface,
);

class Themes {
  static final light = ThemeData(
    // iconButtonTheme:  IconButtonThemeData(style: ButtonStyle(iconColor: MaterialStateProperty.all<Color?>(Colors.red),)),
    iconTheme: IconThemeData(color: Colors.blueGrey.shade500),
    colorScheme: lightColorScheme,
    primaryColor: lightPrimaryColor,
    brightness: Brightness.light,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.lato(
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      titleLarge: GoogleFonts.lato(
        color: Colors.blueGrey.shade900,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      titleSmall: GoogleFonts.lato(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      labelSmall:  GoogleFonts.lato(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      labelMedium:   GoogleFonts.lato(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );

//! ================================= ////


  static final dark = ThemeData(
    
    iconTheme:  const IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      titleMedium: GoogleFonts.lato(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      titleLarge: GoogleFonts.lato(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      titleSmall: GoogleFonts.lato(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
       labelSmall:  GoogleFonts.lato(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      
    ),
    colorScheme: darkColorScheme,
    
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
            iconColor: MaterialStateProperty.all<Color?>(Colors.white))),
    primaryColor: darkPrimaryColor,
    brightness: Brightness.dark,
  );
}


//? DARK ColorScheme
const Color primaryColor = Color.fromARGB(255, 136, 192, 249);
const Color secondaryColor = Color(0XFF1F4061);
const Color errorColor = Color(0xFFD32F2F);
const Color backgroundColor = Color(0xFF828282); // Dark background color
const Color surfaceColor =
    Color(0XFF1F4061); // Slightly lighter than background

const Color onDarkPrimary = Colors.white;
const Color onDarkSecondary = Colors.white;
const Color onDarkError = Colors.white;
const Color onDarkBackground = Colors.white;
const Color onDarkSurface = Colors.white;

const ColorScheme darkColorScheme = ColorScheme.dark(
  primary: primaryColor,
  secondary: secondaryColor,
  error: errorColor,
  background: backgroundColor,
  surface: surfaceColor,
  onPrimary: onDarkPrimary,
  onSecondary: onDarkSecondary,
  onError: onDarkError,
  onBackground: onDarkBackground,
  onSurface: onDarkSurface,
);
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/presentation/resources/font_manager.dart';

TextTheme applicationTextTheme = TextTheme(
  headline1: GoogleFonts.nunito(
      fontWeight: FontWeight.w800,
      color: Colors.white,
      fontSize: FontSizeManager.s35),
  headline6: GoogleFonts.nunito(
      fontWeight: FontWeightManager.w700,
      color: Colors.black,
      fontSize: FontSizeManager.s25),
  caption: GoogleFonts.nunito(
    fontWeight: FontWeightManager.w300,
    color: Colors.black,
    fontSize: FontSizeManager.s16,
  ),
  headline5: GoogleFonts.nunito(
    fontWeight: FontWeightManager.w500,
    color: Colors.black,
    fontSize: FontSizeManager.s20,
  ),
  bodyText1: GoogleFonts.nunito(
    fontWeight: FontWeightManager.w400,
    color: Colors.black,
    fontSize: FontSizeManager.s18,
  ),
);
ThemeData light = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ),
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    centerTitle: true,
  ),
  textTheme: applicationTextTheme,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue.shade500,
    unselectedItemColor: Colors.grey,
  ),
);

ThemeData dark = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ),
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    centerTitle: true,
  ),
  textTheme: applicationTextTheme,
  scaffoldBackgroundColor: Colors.black,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.blue.shade500,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    
  ),
);

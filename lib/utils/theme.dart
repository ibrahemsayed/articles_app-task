import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colors.dart';

ThemeData themeData() {
  bool iSTable = ScreenUtil().screenWidth > 600 ? true : false;

  return ThemeData(
    primaryColor: DARK_GREEN_COLOR,
    unselectedWidgetColor: DARK_GREEN_COLOR,
    scaffoldBackgroundColor: DARK_GREEN_COLOR,
    brightness: Brightness.light,
    splashColor: DARK_GREEN_COLOR,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: DARK_GREEN_COLOR,
    ),
    fontFamily: "Janna-LT",
    primaryIconTheme:
        IconThemeData(color: DARK_GREEN_COLOR, size: iSTable ? 34 : 28),

    iconTheme: IconThemeData(color: DARK_GREEN_COLOR, size: iSTable ? 34 : 28),
    dividerTheme: DividerThemeData(color: DARK_GREEN_COLOR, thickness: 1),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: DARK_GREEN_COLOR,
      titleTextStyle: TextStyle(
        color: DARK_GREEN_COLOR,
        fontSize: iSTable ? 26 : 18,
        fontWeight: FontWeight.bold,
        fontFamily: "Janna-LT",
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: DARK_GREEN_COLOR,
        statusBarIconBrightness: Brightness.light,
      ),
      centerTitle: true,
      actionsIconTheme: IconThemeData(color: DARK_GREEN_COLOR, size: 30),
      iconTheme: IconThemeData(
        color: DARK_GREEN_COLOR,
        size: iSTable ? 34 : 28,
      ),
    ),
    cardTheme: CardTheme(
      color: DARK_GREEN_COLOR,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().screenWidth * 0.02)),
      margin: EdgeInsets.all(ScreenUtil().screenWidth * 0.015),
    ),
    //****************** textTheme ************************* */
    textTheme: TextTheme(
      //****************** 14 - bold ************************* */
      button: TextStyle(
        color: DARK_GREEN_COLOR,
        fontSize: iSTable ? 24 : 14,
        fontFamily: "Janna-LT",
        fontWeight: FontWeight.bold,
      ),
      //****************** 14 - regular ************************* */
      caption: TextStyle(
        color: Colors.red,
        fontSize: iSTable ? 22 : 14,
        fontFamily: "A_Jannat_LT",
        fontWeight: FontWeight.w400,
      ),
      //****************** 20 - bold - DARK_GREEN_COLOR ************************* */
      headline1: TextStyle(
        color: DARK_GREEN_COLOR,
        fontSize: iSTable ? 28 : 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Janna-LT",
      ),
      
      //****************** 18 - bold - DARK_GREEN_COLOR ************************* */
      headline2: TextStyle(
        color: DARK_GREEN_COLOR,
        fontSize: iSTable ? 26 : 18,
        fontWeight: FontWeight.bold,
        fontFamily: "Janna-LT",
      ),
      //****************** 14 - bold - DARK_GREEN_COLOR ************************* */
      headline3: TextStyle(
        color: DARK_GREEN_COLOR,
        fontSize: iSTable ? 22 : 14,
        fontWeight: FontWeight.bold,
        fontFamily: "Janna-LT",
      ),
      //****************** 12 - bold - DARK_GREEN_COLOR ************************* */
      headline4: TextStyle(
        color: DARK_GREEN_COLOR,
        fontSize: iSTable ? 20 : 12,
        fontWeight: FontWeight.bold,
        fontFamily: "Janna-LT",
      ),
      //****************** 18 - regular ************************* */
      bodyText1: TextStyle(
        color: DARK_GREEN_COLOR,
        fontSize: iSTable ? 26 : 18,
        fontFamily: "A_Jannat_LT",
        fontWeight: FontWeight.w400,
      ),
      //****************** 14 - regular ************************* */
      bodyText2: TextStyle(
        color: DARK_GREEN_COLOR,
        fontSize: iSTable ? 22 : 14,
        fontFamily: "A_Jannat_LT",
        fontWeight: FontWeight.w400,
      ),
      //****************** 12 - regular ************************* */
      subtitle1: TextStyle(
        color: DARK_GREEN_COLOR,
        fontSize: iSTable ? 20 : 12,
        fontFamily: "A_Jannat_LT",
        fontWeight: FontWeight.w400,
      ),
      //****************** 12 - regular ************************* */
      headline5: TextStyle(
        color: DARK_GREEN_COLOR,
        fontSize: iSTable ? 24 : 18,
        fontFamily: "ArefRuqaa",
        fontWeight: FontWeight.bold,
      ),
    ),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      
    }),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

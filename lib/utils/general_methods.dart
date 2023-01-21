import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class General {
  static Future<void> routingPage(BuildContext context, Widget page) async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  static Future<void> routingPageWithReplacement(BuildContext context, Widget page) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  static arrowBackFunction(BuildContext context) {
    Navigator.of(context).pop();
  }

  static double iconSize() {
    if (ScreenUtil().screenWidth > 600) {
      return 40;
    } else {
      return 24;
    }
  }

  
}

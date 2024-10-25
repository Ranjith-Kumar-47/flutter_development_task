import 'package:flutter/cupertino.dart';

class ScreenSizeConfig {
  static late double screenWidth;
  static late double screenHeight;

  // Initialize the dimensions
  static void init(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
  }
}

import 'package:flutter/material.dart';

class MyTheme {
  final Color mainColor = const Color(0xFF033B4A);
  final Color secondColor =const Color(0xFFFAF6EA);
  final Color lezzooColors =const Color(0xffE4343E);
  Color colorConvert({String? color}) {
    if (color != null && color != "" && color.length == 6) {
      return Color(int.parse("0xFF" + color));
    } else {
      return mainColor;
    }
  }

}

import 'package:flutter/material.dart';

class DesignColors {
  static Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  // ignore: non_constant_identifier_names
  static MaterialColor COR_TEMA = MaterialColor(0xff005a87, color);
  // ignore: non_constant_identifier_names
  static MaterialColor COR_CINZA_TEMA = MaterialColor(0xff888888, color);
  
  static const Color COR_BACKGROUND = Color(0xffEBE9FE);
}

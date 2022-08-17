import 'package:flutter/material.dart';

class MyConstant {
  // Field
  static Color bgColor = Color.fromARGB(255, 255, 0, 0);
  static Color dark = Color.fromARGB(255, 0, 81, 119);
  static Color active = Color.fromARGB(255, 163, 0, 54);

  // Method
  BoxDecoration basicBox() {
    return BoxDecoration(color: bgColor.withOpacity(0.2));
  }

  TextStyle h1Style() {
    return TextStyle(
      fontSize: 36,
      color: dark,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      fontSize: 18,
      color: dark,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      fontSize: 14,
      color: dark,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle h3ActiveStyle() {
    return TextStyle(
      fontSize: 16,
      color: dark,
      fontWeight: FontWeight.w500,
    );
  }
}

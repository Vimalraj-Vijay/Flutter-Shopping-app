import 'package:flutter/material.dart';

Widget getElevatedButton(String text, VoidCallback onPressed,
    bool textColorBlack, Color backgroundColor) {
  return Center(
    child: Container(
      margin: const EdgeInsets.only(
        top: 8,
        right: 8,
        left: 8,
        bottom: 8,
      ),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
              getTextColorBasedOnBackgroundColor(textColorBlack)),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
        ),
      ),
    ),
  );
}

Color getTextColorBasedOnBackgroundColor(bool textColorBlack) {
  Color textColor;
  if (textColorBlack) {
    textColor = Colors.black87;
  } else {
    textColor = Colors.white;
  }
  return textColor;
}

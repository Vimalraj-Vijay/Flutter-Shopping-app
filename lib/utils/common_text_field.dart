import 'package:flutter/material.dart';

Widget getTextField(String label, TextEditingController textEditingController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: label,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ))),
  );
}

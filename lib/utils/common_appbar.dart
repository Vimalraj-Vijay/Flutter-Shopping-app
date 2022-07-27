import 'package:flutter/material.dart';

PreferredSizeWidget getAppBar(String title, BuildContext context) {
  return AppBar(
    title: Text(title),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}

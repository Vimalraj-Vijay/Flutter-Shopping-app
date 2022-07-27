import 'package:flutter/material.dart';

class GlobalContext {
  static dynamic context;

  static void setContext(BuildContext buildContext) {
    context ??= buildContext;
  }

  static BuildContext getContext() {
    return context;
  }
}

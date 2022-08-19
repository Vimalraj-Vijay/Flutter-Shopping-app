import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../provider/auth.dart';
import '../../shopping_home.dart';

class Splash extends StatefulWidget {
  static var id = "/splash";

  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void didChangeDependencies() {
    final auth = Provider.of<Auth>(context);
    initSplashTimer(auth.isAuth);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 200,
          width: 200,
        ),
      ),
    );
  }

  void initSplashTimer(bool auth) {
    Timer(
      const Duration(seconds: 3),
      () => moveToNextScreen(auth),
    );
  }

  void moveToNextScreen(bool auth) {
    var nextScreen = auth ? ShoppingHome.id : MyHomePage.id;
    Navigator.pushReplacementNamed(context, nextScreen);
  }
}

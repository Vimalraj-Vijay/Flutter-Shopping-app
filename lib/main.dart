import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/app/provider/auth.dart';
import 'package:shopping_app/app/provider/orders.dart';
import 'package:shopping_app/app/provider/products_provider.dart';
import 'package:shopping_app/app/screens/splash/splash.dart';
import 'package:shopping_app/utils/globalcontext.dart';
import 'package:shopping_app/utils/routes.dart';

import 'app/provider/cart.dart';
import 'app/screens/auth_screen.dart';
import 'app/shopping_home.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GlobalContext.setContext(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          create: (context) => ProductProvider("", "", []),
          update: (context, auth, previousProduct) => ProductProvider(
              auth.token,
              auth.userId,
              previousProduct == null ? [] : previousProduct.products),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders("", "", []),
          update: (context, auth, previousOrder) => Orders(auth.token,
              auth.userId, previousOrder == null ? [] : previousOrder.orders),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Shopping app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme:
                GoogleFonts.archivoNarrowTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.amber,
          ),
          home: auth.isAuth
              ? const ShoppingHome()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Splash()
                          : const MyHomePage(),
                ),
          routes: initRoutes(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static var id = "/home";

  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}

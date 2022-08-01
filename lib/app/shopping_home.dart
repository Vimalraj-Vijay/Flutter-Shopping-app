import 'package:flutter/material.dart';
import 'package:shopping_app/app/screens/product_overview_screen.dart';

class ShoppingHome extends StatelessWidget {
  static const id = "/shoppingHome";

  const ShoppingHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProductOverviewScreen();
  }
}

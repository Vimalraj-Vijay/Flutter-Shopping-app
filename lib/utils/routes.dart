import 'package:flutter/material.dart';

import '../app/screens/cart_details.dart';
import '../app/screens/edit_product.dart';
import '../app/screens/manage_products.dart';
import '../app/screens/orders_screen.dart';
import '../app/screens/product_detail.dart';
import '../app/shopping_home.dart';
import '../main.dart';

Map<String, WidgetBuilder> initRoutes() {
  return {
    MyHomePage.id: (BuildContext ctx) => const MyHomePage(),
    ShoppingHome.id: (BuildContext ctx) => const ShoppingHome(),
    ProductDetail.id: (BuildContext ctx) => const ProductDetail(),
    CartDetails.id: (BuildContext ctx) => const CartDetails(),
    OrdersScreen.id: (BuildContext ctx) => const OrdersScreen(),
    ManageProducts.id: (BuildContext ctx) => const ManageProducts(),
    EditProduct.id: (BuildContext ctx) => const EditProduct(),
  };
}

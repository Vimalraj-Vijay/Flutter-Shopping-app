import 'package:flutter/material.dart';
import 'package:shopping_app/app/screens/orders_screen.dart';

import '../screens/manage_products.dart';
import '../shopping_home.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hello user"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text("Shop"),
            onTap: () =>
                {Navigator.of(context).pushReplacementNamed(ShoppingHome.id)},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Orders"),
            onTap: () =>
                {Navigator.of(context).pushReplacementNamed(OrdersScreen.id)},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Manage Products"),
            onTap: () =>
                {Navigator.of(context).pushReplacementNamed(ManageProducts.id)},
          ),
          const Divider(),
        ],
      ),
    );
  }
}

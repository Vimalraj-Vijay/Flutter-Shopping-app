import 'package:flutter/material.dart';
import 'package:shopping_app/app/provider/cart.dart';
import 'package:shopping_app/app/provider/products_provider.dart';
import 'package:shopping_app/app/screens/cart_details.dart';
import 'package:shopping_app/app/utils/filter_options.dart';
import 'package:shopping_app/app/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../../utils/strings.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_item.dart';

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavourites = false;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products =
        _showFavourites ? productData.favourites : productData.products;
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.title),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) => {
                    setState(() {
                      if (selectedValue == FilterOptions.all) {
                        _showFavourites = false;
                      } else {
                        _showFavourites = true;
                      }
                    })
                  },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text("Only Favourites"),
                      value: FilterOptions.favourites,
                    ),
                    const PopupMenuItem(
                      child: Text("Show All"),
                      value: FilterOptions.all,
                    )
                  ]),
          Consumer<Cart>(
            builder: (context, carts, ch) => Badge(
              child: ch!,
              value: carts.cartCount().toString(),
              color: Colors.red,
            ),
            child: IconButton(
                onPressed: () => {Navigator.pushNamed(context, CartDetails.id)},
                icon: const Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: products.isNotEmpty
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (cxt, index) => ChangeNotifierProvider.value(
                // ignore: prefer_const_constructors
                child: ProductItem(),
                value: products[index],
              ),
              itemCount: products.length,
              padding: const EdgeInsets.all(10),
            )
          : const Center(child: Text("No favourites found")),
    );
  }
}

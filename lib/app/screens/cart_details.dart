import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/app/provider/cart.dart' show Cart;
import 'package:shopping_app/app/widgets/cart_item.dart';
import 'package:shopping_app/app/widgets/empty_cart.dart';
import 'package:shopping_app/utils/common_appbar.dart';

import '../provider/orders.dart';

class CartDetails extends StatelessWidget {
  static const id = "/cartDetails";

  const CartDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final placeOrder = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: getAppBar("Your cart", context),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      "\$ ${cart.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (cart.cartCount() > 0)
                    ElevatedButton(
                      onPressed: () => {
                        placeOrder.addOrders(
                          cart.items.values.toList(),
                          cart.totalAmount,
                        ),
                        cart.clearCart()
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.purple),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                      ),
                      child: const Text("ORDER NOW"),
                    )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Cart Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: (cart.cartCount() > 0) ? 15 : 5,
          ),
          Expanded(
            child: (cart.cartCount() > 0)
                ? ListView.builder(
                    itemBuilder: (ctx, index) =>
                        CartItem(cart: cart, index: index),
                    itemCount: cart.cartCount())
                : const EmptyCart(),
          )
        ],
      ),
    );
  }
}

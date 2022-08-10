import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/app/provider/cart.dart' show Cart;
import 'package:shopping_app/app/widgets/cart_item.dart';
import 'package:shopping_app/app/widgets/empty_cart.dart';
import 'package:shopping_app/utils/common_appbar.dart';

import '../provider/orders.dart';
import 'orders_screen.dart';

class CartDetails extends StatelessWidget {
  static const id = "/cartDetails";

  const CartDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final placeOrder = Provider.of<Orders>(context, listen: false);
    final scaffold = ScaffoldMessenger.of(context);
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
                    OrderButton(
                      cart: cart,
                      placeOrder: placeOrder,
                      scaffoldMessenger: scaffold,
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

class OrderButton extends StatefulWidget {
  const OrderButton(
      {Key? key,
      required this.cart,
      required this.placeOrder,
      required this.scaffoldMessenger})
      : super(key: key);

  final Orders placeOrder;
  final ScaffoldMessengerState scaffoldMessenger;
  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const SizedBox(
            width: 20, height: 20, child: CircularProgressIndicator())
        : ElevatedButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              try {
                await widget.placeOrder
                    .addOrders(
                  widget.cart.items.values.toList(),
                  widget.cart.totalAmount,
                )
                    .then((value) {
                  widget.cart.clearCart();
                  Fluttertoast.showToast(
                      msg: "Order Placed Successfully",
                      toastLength: Toast.LENGTH_LONG);
                  Navigator.of(context).pushNamed(OrdersScreen.id);
                });
              } catch (error) {
                widget.scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text(
                        "Failed to place an order, Please try again later"),
                  ),
                );
              }
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.purple),
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
            child: const Text("ORDER NOW"),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  final Cart cart;
  final int index;

  const CartItem({Key? key, required this.cart, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cart.items.values.toList()[index].id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: 10,
        ),
        margin: const EdgeInsets.all(10),
      ),
      onDismissed: (_) => {
        Provider.of<Cart>(context, listen: false)
            .removeItemFromCart(cart.items.keys.toList()[index])
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Remove from cart?"),
                  content: const Text("Are you sure want to remove from cart"),
                  actions: [
                    TextButton(
                      onPressed: () => {Navigator.of(ctx).pop(true)},
                      child: const Text("Yes"),
                    ),
                    TextButton(
                      onPressed: () => {Navigator.of(ctx).pop(false)},
                      child: const Text("No"),
                    )
                  ],
                ));
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.purpleAccent)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 15,
                  child: Text(
                    cart.items.values.toList()[index].quantity.toString(),
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                cart.items.values.toList()[index].title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "\$ ${cart.items.values.toList()[index].price.toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

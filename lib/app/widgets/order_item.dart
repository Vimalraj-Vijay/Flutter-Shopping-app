import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_app/app/provider/orders.dart'
    as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;

  // ignore: use_key_in_widget_constructors
  const OrderItem({required this.orderItem});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  final dateFormat = "dd MMM yyyy - hh:mm a";
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Image(
                image: AssetImage("assets/images/order_placed.png"),
                fit: BoxFit.fill,
              ),
            ),
            title: Text("Order Placed -- \$ ${widget.orderItem.total}"),
            subtitle:
                Text(DateFormat(dateFormat).format(widget.orderItem.dateTime)),
            trailing: IconButton(
              onPressed: () => {
                setState(() {
                  _isExpanded = !_isExpanded;
                })
              },
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: min(widget.orderItem.products.length * 20.0 + 25, 200),
              child: ListView(
                children: widget.orderItem.products
                    .map((prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prod.title,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87),
                            ),
                            Text(
                              "${prod.quantity.toString()} X \$ ${prod.price.toString()}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87),
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

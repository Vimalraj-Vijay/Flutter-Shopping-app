import 'package:flutter/material.dart';
import 'package:shopping_app/app/provider/orders.dart' show Orders;
import 'package:shopping_app/app/widgets/app_drawer.dart';
import 'package:shopping_app/app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const id = "/ordersScreen";

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      drawer: const AppDrawer(),
      body: orders.ordersCount == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage("assets/images/order_now.png"),
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "No orders found.\nPlace your order now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) =>
                  OrderItem(orderItem: orders.orders[index]),
              itemCount: orders.ordersCount),
    );
  }
}

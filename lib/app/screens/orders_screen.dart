import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/app/provider/orders.dart' show Orders;
import 'package:shopping_app/app/widgets/app_drawer.dart';
import 'package:shopping_app/app/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const id = "/ordersScreen";

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _fetchOrders;

  Future _obtainOrders() {
    return Provider.of<Orders>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    _fetchOrders = _obtainOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<Orders>(
              builder: (context, orders, child) => orders.ordersCount == 0
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
                  : snapshot.hasError
                      ? const Center(
                          child:
                              Text("An Error Occurred Please try again later"),
                        )
                      : ListView.builder(
                          itemBuilder: (ctx, index) =>
                              OrderItem(orderItem: orders.orders[index]),
                          itemCount: orders.ordersCount),
            );
          }
        },
      ),
    );
  }
}

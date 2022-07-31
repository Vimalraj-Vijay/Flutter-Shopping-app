import 'package:flutter/foundation.dart';

import '../../app/provider/cart.dart';

class OrderItem {
  String id;
  double total;
  DateTime dateTime;
  List<CartItem> products;

  OrderItem({
    required this.id,
    required this.total,
    required this.dateTime,
    required this.products,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orderItem = [];

  List<OrderItem> get orders {
    return [..._orderItem];
  }

  int get ordersCount {
    return _orderItem.length;
  }

  void addOrders(List<CartItem> cartItem, double total) {
    _orderItem.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        total: total,
        dateTime: DateTime.now(),
        products: cartItem,
      ),
    );
    notifyListeners();
  }
}

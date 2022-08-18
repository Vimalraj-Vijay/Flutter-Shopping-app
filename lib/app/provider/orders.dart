import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/utils/api_constants.dart';

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
  final String _authToken;
  final String _userId;
  List<OrderItem> _orderItem = [];

  Orders(this._authToken, this._userId, this._orderItem);

  List<OrderItem> get orders {
    return [..._orderItem];
  }

  int get ordersCount {
    return _orderItem.length;
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.ordersEndpoint}/$_userId${ApiConstants.urlFormat}${ApiConstants.auth}$_authToken");
    try {
      final response = await http.get(url);
      final extractedResponse =
          jsonDecode(response.body) as Map<String, dynamic>;
      // ignore: unnecessary_null_comparison
      if (extractedResponse == null) {
        return;
      }
      final List<OrderItem> loadOrders = [];
      extractedResponse.forEach((key, value) {
        loadOrders.add(
          OrderItem(
            id: key,
            total: value['total'],
            dateTime: DateTime.parse(value['dateTime']),
            products: (value['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(item['id'], item['title'],
                      item['quantity'], item['price']),
                )
                .toList(),
          ),
        );
      });
      _orderItem = loadOrders.reversed.toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addOrders(List<CartItem> cartItem, double total) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.ordersEndpoint}/$_userId${ApiConstants.urlFormat}${ApiConstants.auth}$_authToken");
    var timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            "total": total,
            "dateTime": timeStamp.toIso8601String(),
            "products": cartItem
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList()
          }));
      _orderItem.insert(
        0,
        OrderItem(
          id: jsonDecode(response.body)['name'],
          total: total,
          dateTime: timeStamp,
          products: cartItem,
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/app/provider/cart.dart';
import 'package:shopping_app/app/provider/orders.dart';

void main() async {
  Orders orders = Orders("", "", []);
  List<CartItem> cartItem = [];

  setUp(() {
    // given
    cartItem.clear();
    cartItem.add(CartItem("id", "title", 1, 34.0));
  });

  group("add Orders", () {
    test(
        "given order is added when order count is called then it returns total order count",
        () async {
      // when
      orders.addOrders(cartItem, 109);

      // then
      expect(orders.ordersCount != 0, true);
    });

    test(
        "given order is added when get orders is called then it returns total order list",
        () async {
      // when
      orders.addOrders(cartItem, 109);

      // then
      expect(orders.orders.isNotEmpty, true);
    });
  });
}

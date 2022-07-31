import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/app/provider/cart.dart';

void main() async {
  Cart cart = Cart();

  setUp(() {
    // given
    cart.clearCart();
    cart.addCart("1", "abc", 10.0);
    cart.addCart("2", "abc", 20.0);
  });

  group('Adding to cart', () {
    test(
        'given cart is added when totalAmount is called then it should return not null',
        () async {
      // when
      var actual = cart.totalAmount;

      // then
      expect(actual, isNotNull);
    });

    test(
        'given cart is added when totalAmount is called then it should return true',
        () async {
      // when
      var actual = cart.totalAmount;

      // then
      expect(actual != 0, isTrue);
    });

    test(
        'given cart is added when cartCount is called then it should return true',
        () async {
      // when
      var actual = cart.cartCount();

      // then
      expect(actual != 0, isTrue);
    });
  });

  group('Removing item from the cart', () {
    test(
        'given cart is added when removeItemFromCart is called then it should removes the particular item from cart and it count equals to 1',
        () async {
      // when
      cart.removeItemFromCart("1");

      // then
      expect(cart.cartCount() == 1, isTrue);
    });

    test(
        'given cart is added item with multiple quantity when removeSingleItemFromCart is called then it should removes the single item from cart',
        () async {
      // given
      cart.addCart("1", "abc", 10.0);

      // when
      cart.removeSingleItemFromCart("1");

      // then
      expect(cart.items["1"]?.quantity == 1, isTrue);
    });

    test(
        'given cart is added item with single quantity when removeSingleItemFromCart is called then it should removes the item from cart',
        () async {
      // when
      cart.removeSingleItemFromCart("1");

      // then
      expect(cart.items.length == 1, isTrue);
    });

    test(
        'given cart is added when clearCart is called then it should all items from cart and it count equals to 0',
        () async {
      // when
      cart.clearCart();

      // then
      expect(cart.cartCount() == 0, isTrue);
    });
  });
}

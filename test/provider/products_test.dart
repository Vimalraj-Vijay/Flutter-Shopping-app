import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/app/provider/products.dart';

void main() async {
  Products products;

  test(
      'given product is added when toggleFavorite it returns the products favourite as true',
      () async {
    // given
    products = Products(
        id: "id",
        title: "title",
        description: "description",
        imageUrl: "imageUrl",
        price: 293,
        isFavorite: false);

    // when
    products.toggleFavorite();

    // then
    expect(products.isFavorite, isTrue);
  });

  test(
      'given product is added when toggleFavorite it returns the products favourite as false',
      () async {
    // given
    products = Products(
        id: "id",
        title: "title",
        description: "description",
        imageUrl: "imageUrl",
        price: 293,
        isFavorite: true);

    // when
    products.toggleFavorite();

    // then
    expect(products.isFavorite, isFalse);
  });
}

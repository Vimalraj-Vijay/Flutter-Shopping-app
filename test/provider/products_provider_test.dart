import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/app/provider/products.dart';
import 'package:shopping_app/app/provider/products_provider.dart';

void main() async {
  ProductProvider productProvider = ProductProvider();

  group('Adding to cart', () {
    test(
        'given product is added when addProduct is called then returns the list of products',
        () async {
      // given
      productProvider.addProducts(Products(
          id: "id",
          title: "title",
          description: "description",
          imageUrl: "imageUrl",
          price: 98));
      // when
      var actual = productProvider.products;

      // then
      expect(actual, isNotEmpty);
    });

    test(
        'given product is update when update is called then returns the same list of products with updated values',
        () async {
      // when
      productProvider.updateProduct(
          "p1",
          Products(
              id: "p1",
              title: "title",
              description: "description",
              imageUrl: "imageUrl",
              price: 66));

      // then
      var actual = productProvider.products;
      expect(actual, isNotEmpty);
    });

    test(
        'given product is delete when deleteProduct is called then returns the list of products',
        () async {
      var productSize = productProvider.products.length;
      // when
      productProvider.deleteProduct("p1");

      // then
      var actual = productProvider.products;
      expect(actual.length, productSize - 1);
    });

    test(
        'given product is find by id when getProductId is called then returns a product',
        () async {
      // when
      var actual = productProvider.getProductById("p2");

      // then
      expect(actual, isNotNull);
    });

    test(
        'given product is favorite get favourites is called then returns a product',
        () async {
      // when
      var actual = productProvider.favourites;

      // then
      expect(actual, isNotEmpty);
    });
  });
}

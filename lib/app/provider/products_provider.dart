import 'package:flutter/material.dart';
import 'package:shopping_app/app/provider/products.dart';

class ProductProvider with ChangeNotifier {
  final List<Products> _items = [
    Products(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Products(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Products(
        id: 'p3',
        title: 'Yellow Scarf',
        description: 'Warm and cozy - exactly what you need for the winter.',
        price: 19.99,
        imageUrl:
            'https://www.pashminawear.com/1316/yellow-cashmere-scarf-in-twill-weave.jpg',
        isFavorite: true),
    Products(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Products> get products {
    return [..._items];
  }

  List<Products> get favourites {
    return _items.where((element) => element.isFavorite).toList();
  }

  Products getProductById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProducts(Products products) {
    final _addProduct = Products(
        id: DateTime.now().toString(),
        title: products.title,
        description: products.description,
        imageUrl: products.imageUrl,
        price: products.price);
    _items.insert(0, _addProduct);
    notifyListeners();
  }

  void updateProduct(String id, Products products) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = products;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}

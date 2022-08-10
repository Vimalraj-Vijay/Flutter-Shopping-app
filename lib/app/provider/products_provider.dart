import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/app/provider/products.dart';
import 'package:shopping_app/utils/api_constants.dart';
import 'package:shopping_app/utils/custom_exception.dart';

class ProductProvider with ChangeNotifier {
  List<Products> _items = [];

  List<Products> get products {
    return [..._items];
  }

  List<Products> get favourites {
    return _items.where((element) => element.isFavorite).toList();
  }

  Products getProductById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.productsEndpoint +
        ApiConstants.urlFormat);
    try {
      final response = await http.get(url);
      final extractedResponse =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<Products> loadProducts = [];
      extractedResponse.forEach((key, value) {
        loadProducts.add(
          Products(
            id: key,
            title: value['title'],
            description: value['description'],
            imageUrl: value['imageUrl'],
            price: value['price'],
            isFavorite: value['isFavorite'],
          ),
        );
      });
      _items = loadProducts;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProducts(Products products) async {
    final url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.productsEndpoint +
        ApiConstants.urlFormat);
    try {
      final response = await http.post(url,
          body: json.encode({
            "title": products.title,
            "description": products.description,
            "imageUrl": products.imageUrl,
            "price": products.price,
            "isFavorite": products.isFavorite,
          }));

      final addProduct = Products(
          id: json.decode(response.body)["name"],
          title: products.title,
          description: products.description,
          imageUrl: products.imageUrl,
          price: products.price,
          isFavorite: products.isFavorite);
      _items.insert(0, addProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Products products, bool isFav) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}/$id${ApiConstants.urlFormat}");
      dynamic updateProduct;
      if (isFav) {
        products.toggleFavorite();
        updateProduct = json.encode({
          "isFavorite": products.isFavorite,
        });
      } else {
        updateProduct = json.encode({
          "title": products.title,
          "description": products.description,
          "imageUrl": products.imageUrl,
          "price": products.price,
        });
      }
      final response = await http.patch(url, body: updateProduct);
      if (response.statusCode >= 400) {
        throw CustomException("Http Request failed");
      } else {
        _items[prodIndex] = products;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}/$id${ApiConstants.urlFormat}");
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      throw CustomException("Http Request failed");
    } else {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}

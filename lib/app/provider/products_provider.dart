import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/app/provider/products.dart';
import 'package:shopping_app/utils/api_constants.dart';
import 'package:shopping_app/utils/custom_exception.dart';

class ProductProvider with ChangeNotifier {
  final String _authToken;
  final String _userID;

  List<Products> _items = [];

  ProductProvider(this._authToken, this._userID, this._items);

  List<Products> get products {
    return [..._items];
  }

  List<Products> get favourites {
    return _items.where((element) => element.isFavorite).toList();
  }

  Products getProductById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchProducts([bool isFilterByUser = false]) async {
    var filterBy =
        isFilterByUser ? '&orderBy="creatorId"&equalTo="$_userID"' : '';
    final url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.productsEndpoint +
        ApiConstants.urlFormat +
        ApiConstants.auth +
        _authToken +
        filterBy);
    try {
      final response = await http.get(url);
      final extractedResponse =
          jsonDecode(response.body) as Map<String, dynamic>;
      final favUrl = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.userFavourite}/$_userID/${ApiConstants.urlFormat}${ApiConstants.auth}$_authToken");
      final userFavoriteResponse = await http.get(favUrl);
      final favoriteData = json.decode(userFavoriteResponse.body);
      final List<Products> loadProducts = [];
      extractedResponse.forEach((key, value) {
        loadProducts.add(
          Products(
            id: key,
            title: value['title'],
            description: value['description'],
            imageUrl: value['imageUrl'],
            price: value['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[key] ?? false,
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
        ApiConstants.urlFormat +
        ApiConstants.auth +
        _authToken);
    try {
      final response = await http.post(url,
          body: json.encode({
            "title": products.title,
            "description": products.description,
            "imageUrl": products.imageUrl,
            "price": products.price,
            "creatorId": _userID
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

  Future<void> updateProduct(
      String id, Products products, bool isFav, String userId) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}/$id${ApiConstants.urlFormat}${ApiConstants.auth}$_authToken");
      dynamic updateProduct;
      http.Response response;
      if (isFav) {
        url = Uri.parse(
            "${ApiConstants.baseUrl}${ApiConstants.userFavourite}/$userId/$id${ApiConstants.urlFormat}${ApiConstants.auth}$_authToken");
        products.toggleFavorite();
        updateProduct = json.encode(
          products.isFavorite,
        );
        response = await http.put(url, body: updateProduct);
      } else {
        updateProduct = json.encode({
          "title": products.title,
          "description": products.description,
          "imageUrl": products.imageUrl,
          "price": products.price,
        });
        response = await http.patch(url, body: updateProduct);
      }
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
        "${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}/$id${ApiConstants.urlFormat}${ApiConstants.auth}$_authToken");
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      throw CustomException("Http Request failed");
    } else {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}

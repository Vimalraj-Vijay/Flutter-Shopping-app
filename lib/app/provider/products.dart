import 'package:flutter/foundation.dart';

class Products with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String creatorId;
  bool isFavorite;

  Products(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.isFavorite = false,
      this.creatorId = ""});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

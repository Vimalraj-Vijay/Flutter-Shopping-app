import 'package:flutter/material.dart';
import 'package:shopping_app/app/provider/products_provider.dart';
import 'package:shopping_app/utils/common_appbar.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  static const id = "/productDetail";

  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<ProductProvider>(context, listen: false).getProductById(id);
    return Scaffold(
      appBar: getAppBar(loadedProduct.title, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 350,
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(loadedProduct.imageUrl),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "\$ ${loadedProduct.price.toString()}",
                style: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 15,
                left: 15,
              ),
              child: Text(
                loadedProduct.description,
                softWrap: true,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

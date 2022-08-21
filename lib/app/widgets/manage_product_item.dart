import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/app/provider/products.dart';
import 'package:shopping_app/app/provider/products_provider.dart';

import '../screens/edit_product.dart';

class ManageProductItem extends StatelessWidget {
  final Products products;

  const ManageProductItem({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image(
                image: NetworkImage(products.imageUrl),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black87.withAlpha(150)),
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              products.title,
                              maxLines: 2,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\$ ${products.price.toStringAsFixed(2)}",
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, EditProduct.id,
                                  arguments: products.id);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () async {
                              try {
                                await Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .deleteProduct(products.id)
                                    .then((value) {
                                  scaffold.showSnackBar(const SnackBar(
                                      content: Text(
                                    "Item deleted successfully",
                                    textAlign: TextAlign.center,
                                  )));
                                });
                              } catch (error) {
                                scaffold.showSnackBar(const SnackBar(
                                    content: Text(
                                  "Failed to delete",
                                  textAlign: TextAlign.center,
                                )));
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

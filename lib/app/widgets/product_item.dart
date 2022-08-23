import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/app/provider/auth.dart';
import 'package:shopping_app/app/provider/products.dart';
import 'package:shopping_app/app/provider/products_provider.dart';
import 'package:shopping_app/app/screens/product_detail.dart';

import '../provider/cart.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    final scaffold = ScaffoldMessenger.of(context);
    final isShowCart = auth.userId != product.creatorId;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Center(
            child: Container(
              alignment: isShowCart ? Alignment.center : Alignment.centerLeft,
              child: Text(
                product.title,
              ),
            ),
          ),
          backgroundColor: Colors.black45,
          leading: Consumer<Products>(
            builder: (context, product, _) => IconButton(
              iconSize: 20,
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () async {
                try {
                  await Provider.of<ProductProvider>(context, listen: false)
                      .updateProduct(product.id, product, true, auth.userId)
                      .then((value) {
                    scaffold.showSnackBar(
                      const SnackBar(
                        content: Text("Updated Successfully"),
                      ),
                    );
                  });
                } catch (error) {
                  product.toggleFavorite();
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text("Failed to update"),
                    ),
                  );
                }
              },
            ),
          ),
          trailing: Visibility(
            visible: isShowCart,
            child: IconButton(
              iconSize: 20,
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addCart(product.id, product.title, product.price);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Item Added Successfully"),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cart.removeSingleItemFromCart(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetail.id,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

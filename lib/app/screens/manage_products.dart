import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/app/provider/products_provider.dart';
import 'package:shopping_app/app/screens/edit_product.dart';
import 'package:shopping_app/app/widgets/app_drawer.dart';
import 'package:shopping_app/app/widgets/manage_product_item.dart';

class ManageProducts extends StatelessWidget {
  static const id = "/manageProducts";

  const ManageProducts({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProduct.id, arguments: "");
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawer(),
      body: productData.products.isEmpty
          ? const Center(child: Text('No Products Found. Add a product'))
          : RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: ListView.builder(
                itemBuilder: (_, index) =>
                    ManageProductItem(products: productData.products[index]),
                itemCount: productData.products.length,
              ),
            ),
    );
  }
}

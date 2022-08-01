import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/app/provider/products.dart';
import 'package:shopping_app/app/provider/products_provider.dart';

class EditProduct extends StatefulWidget {
  static const id = "/editProduct";

  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _editProduct =
      Products(id: "", title: "", description: "", imageUrl: "", price: 0);

  var _isInit = true;
  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageurl": "",
  };

  @override
  void dispose() {
    _imageUrlController.removeListener(_updateImageUrl);
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String;
      if (productId.isEmpty) {
        _editProduct =
            Provider.of<ProductProvider>(context).getProductById(productId);
        _initValues = {
          "title": _editProduct.title,
          "description": _editProduct.description,
          "price": _editProduct.price.toString(),
          "imageurl": "",
        };
        _imageUrlController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlController.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final _isValid = _form.currentState?.validate();
    if (!_isValid!) {
      return;
    }
    _form.currentState?.save();
    if (_editProduct.id.isEmpty) {
      Provider.of<ProductProvider>(context, listen: false)
          .addProducts(_editProduct);
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Product"),
          actions: [
            IconButton(
                onPressed: () {
                  _saveForm();
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
              key: _form,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _initValues["title"],
                      decoration: const InputDecoration(
                        hintText: "Enter the title",
                        labelText: "Title",
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide the title";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editProduct = Products(
                            id: _editProduct.id,
                            title: value.toString(),
                            description: _editProduct.description,
                            imageUrl: _editProduct.imageUrl,
                            price: _editProduct.price,
                            isFavorite: _editProduct.isFavorite);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _initValues["description"],
                      decoration: const InputDecoration(
                        hintText: "Enter the Description",
                        labelText: "Description",
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                      ),
                      minLines: 1,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide the description";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editProduct = Products(
                            id: _editProduct.id,
                            title: _editProduct.title,
                            description: value.toString(),
                            imageUrl: _editProduct.imageUrl,
                            price: _editProduct.price,
                            isFavorite: _editProduct.isFavorite);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _initValues["price"],
                      decoration: const InputDecoration(
                        hintText: "Enter the price",
                        labelText: "Price",
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide the price";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please enter a valid number";
                        }

                        if (double.tryParse(value)! <= 0) {
                          return "Please enter a valid number greater than zero";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      focusNode: _priceFocusNode,
                      onSaved: (value) {
                        _editProduct = Products(
                            id: _editProduct.id,
                            title: _editProduct.title,
                            description: _editProduct.description,
                            imageUrl: _editProduct.imageUrl,
                            price: double.parse(value.toString()),
                            isFavorite: _editProduct.isFavorite);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: (_imageUrlController.text.isEmpty &&
                                  !Uri.parse(_imageUrlController.text)
                                      .isAbsolute)
                              ? const Center(child: Text("Enter image url"))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      Image.network(_imageUrlController.text)),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter the image url",
                              labelText: "Image url",
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please provide the image url";
                              }

                              if (!value.startsWith("http") &&
                                  !value.startsWith("https")) {
                                return "Please provide the valid image url";
                              }

                              if (!value.endsWith(".png") &&
                                  !value.endsWith(".jpeg") &&
                                  !value.endsWith(".jpg")) {
                                return "Please provide the valid image url";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            focusNode: _imageFocusNode,
                            controller: _imageUrlController,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_imageUrlController) {
                              FocusScope.of(context).unfocus();
                            },
                            onSaved: (value) {
                              _editProduct = Products(
                                  id: _editProduct.id,
                                  title: _editProduct.title,
                                  description: _editProduct.description,
                                  imageUrl: value.toString(),
                                  price: _editProduct.price,
                                  isFavorite: _editProduct.isFavorite);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

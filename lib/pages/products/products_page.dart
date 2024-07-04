// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salat/models/cart.dart';
import 'package:salat/pages/cart/cart_page.dart';

import '../../components/my_products_grid.dart';
import '../../models/product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.category});
  final String category;

  @override
  State<ProductsPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductsPage> {
  late Future<List<Product>> productFuture;
  late Cart cart;

  @override
  void initState() {
    productFuture = getProduct(context);
    cart = Cart();
    super.initState();
  }

  static Future<List<Product>> getProduct(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle
        .loadString('assets/products/product.json'); // Corrected path

    if (data.isEmpty) {
      throw Exception("file is empty");
    }

    final List<dynamic> body = jsonDecode(data); // Cast to List<dynamic>
    return body
        .map<Product>((json) => Product.fromJson(json))
        .toList(); // Convert to List<Product>
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: FutureBuilder<List<Product>>(
          future: productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              final Product = snapshot.data!
                  .where((product) => product.category == widget.category)
                  .toList();
              ;
              return ProductsGrid(
                products: Product,
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartPage()));
        },
        backgroundColor: const Color(0xff03045e),
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salat/models/cart.dart';
import 'package:salat/models/product.dart';

class ProductsGrid extends StatefulWidget {
  final List<Product> products;

  const ProductsGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  void _addProduct(Product product) {
    Provider.of<Cart>(context, listen: false).addItem(product);
  }

  void _subtractProduct(Product product) {
    Provider.of<Cart>(context, listen: false).removeItem(product.id);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        final product = widget.products[index];
        final cart = Provider.of<Cart>(context);

        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  product.productName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('Артикул: ${product.id.substring(4, 7)}'),
              Text('1 ${product.measureValue}. / ${product.price.round()} тг'),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.black, style: BorderStyle.solid, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          _subtractProduct(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${product.productName} удален с корзины'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 22),
                        )),
                    Text(
                      '${cart.items[product.id]?.quantity ?? 0}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          _addProduct(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${product.productName} добавлен в корзину'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
              ),

              // GestureDetector(
              //   onTap: () {
              //     _addProduct(product);
              //   },
              //   child: Container(
              //     alignment: Alignment.center,
              //     width: 150,
              //     height: 40,
              //     decoration: BoxDecoration(
              //       color: const Color(0xff004b23),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: const Text(
              //       'В КОРЗИНУ',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}

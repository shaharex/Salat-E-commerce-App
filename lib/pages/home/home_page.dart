import 'package:flutter/material.dart';
import 'package:salat/pages/products/products_page.dart';

import 'data/product_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productsImages.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductsPage(
                          category: productsName[index],
                        )));
          },
          child: Container(
            alignment: Alignment.center,
            width: 150,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      "assets/fruits_main/${productsImages[index]}",
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 150,
                  child: Text(
                    productsName[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

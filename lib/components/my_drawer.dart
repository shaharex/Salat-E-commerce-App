import 'package:flutter/material.dart';
import 'package:salat/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // salat logo
              DrawerHeader(
                child: Center(
                  child: SizedBox(
                    width: 120,
                    child: Image.asset("assets/logo/salat_logo.png"),
                  ),
                ),
              ),
              // home tile
              MyListTile(
                text: 'Категории',
                icon: Icons.food_bank_outlined,
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              // cart tile
              MyListTile(
                text: 'Корзина',
                icon: Icons.shopping_cart,
                onTap: () {
                  // pop drawer first
                  Navigator.pop(context);

                  // go to cart page
                  Navigator.pushNamed(context, '/cart_page');
                },
              ),
            ],
          ),
          MyListTile(
            text: 'Заказы',
            icon: Icons.people,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/checkin_page');
            },
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salat/components/my_textfield.dart';
import 'package:salat/models/cart.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  final _districtController = TextEditingController();
  final _streetController = TextEditingController();
  final _homeController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _anyCommentsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _districtController.dispose();
    _streetController.dispose();
    _homeController.dispose();
    _apartmentController.dispose();
    _anyCommentsController.dispose();
    super.dispose();
  }

  Future addOrderDetails(Cart cart) async {
    await FirebaseFirestore.instance.collection('orders').add({
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'number': _numberController.text.trim(),
      'district': _districtController.text.trim(),
      'street': _streetController.text.trim(),
      'home': _homeController.text.trim(),
      'apartment': _apartmentController.text.trim(),
      'comments': _anyCommentsController.text.trim(),
      'totalAmount': cart.totalAmount.round(),
      'items': cart.items.values.map((cartItem) {
        return {
          'productId': cartItem.id,
          'productName': cartItem.productName,
          'quantity': cartItem.quantity,
          'price': cartItem.price.round(),
        };
      }).toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, index) {
                  final productId = cart.items.keys.toList()[index];
                  final product = cart.items[productId];

                  return ListTile(
                    title: Text(product!.productName),
                    subtitle: Text('Количество: ${product.quantity}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            cart.removeItem(productId);
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text(
                            'Итого: ${(product.price * product.quantity).round()}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            Text(
              'К оплате: ${cart.totalAmount.round()} тг',
              style: const TextStyle(fontSize: 20),
            ),
            MyTextField(
              controller: _nameController,
              hintTextFor: 'Ваше имя',
              inputType: TextInputType.emailAddress,
            ),
            MyTextField(
              controller: _emailController,
              hintTextFor: 'Ваш e-mail',
              inputType: TextInputType.emailAddress,
            ),
            MyTextField(
              controller: _numberController,
              hintTextFor: 'Ваш номер',
              inputType: TextInputType.phone,
            ),
            MyTextField(
              controller: _districtController,
              hintTextFor: 'Жилой Комплекс',
              inputType: TextInputType.text,
            ),
            MyTextField(
              controller: _streetController,
              hintTextFor: 'Улица',
              inputType: TextInputType.text,
            ),
            MyTextField(
              controller: _homeController,
              hintTextFor: 'Номер дома',
              inputType: TextInputType.number,
            ),
            MyTextField(
              controller: _apartmentController,
              hintTextFor: 'Номер квартиры',
              inputType: TextInputType.number,
            ),
            MyTextField(
              controller: _anyCommentsController,
              hintTextFor: 'Для ваших комментариев',
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                addOrderDetails(cart);
                setState(() {
                  cart.clear();
                });
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xff004b23),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: const Text(
                  'Оформить заказ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

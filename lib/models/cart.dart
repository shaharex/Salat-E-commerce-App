import 'package:flutter/material.dart';
import 'package:salat/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, Product> _items = {};

  Map<String, Product> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, product) {
      total += product.price * product.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingProduct) => Product(
          productName: existingProduct.productName,
          id: existingProduct.id,
          measureValue: existingProduct.measureValue,
          price: existingProduct.price,
          category: existingProduct.category,
          quantity: existingProduct.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => Product(
          productName: product.productName,
          id: product.id,
          measureValue: product.measureValue,
          price: product.price,
          category: product.category,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

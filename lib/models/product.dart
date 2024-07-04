class Product {
  final String productName;
  final String id;
  final String measureValue;
  final double price;
  final String category;
  int quantity;

  Product({
    required this.productName,
    required this.id,
    required this.measureValue,
    required this.price,
    required this.category,
    this.quantity = 1,
  });

  static Product fromJson(json) => Product(
        productName: json['Название товара'],
        id: json['Штрихкод'],
        measureValue: json['Ед. изм'],
        price: json['Цена'],
        category: json['Категория'],
      );
}

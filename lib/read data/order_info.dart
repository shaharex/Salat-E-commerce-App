import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetOrderInfo extends StatelessWidget {
  const GetOrderInfo({super.key, required this.documentId});

  final String documentId;

  @override
  Widget build(BuildContext context) {
    // get the collection
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');

    return FutureBuilder<DocumentSnapshot>(
      future: orders.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Color(0xff004b23),
                  width: 1,
                )),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${data['name']}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff03045e)),
                    ),
                    Text(
                      '${data['totalAmount']} тг',
                      style: const TextStyle(
                        color: const Color.fromARGB(255, 40, 170, 45),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 5),

                // contact info
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.contact_emergency, color: Color(0xff03045e)),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Контактная информация',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff03045e)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${data['email']}'),
                    Text('${data['number']}'),
                  ],
                ),
                const SizedBox(height: 5),

                const Divider(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 5),

                // addres
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map_outlined, color: Color(0xff03045e)),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Адрес',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff03045e)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Жилой комплекс:'),
                    Text('${data['district']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Улица:'),
                    Text('${data['street']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Дом:'),
                    Text('${data['home']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Квартира:'),
                    Text('${data['apartment']}'),
                  ],
                ),
                const SizedBox(height: 5),

                const Divider(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 5),

                // order info
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.food_bank_outlined, color: Color(0xff03045e)),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Информация о заказе',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff03045e)),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    itemCount: data['items'].length,
                    itemBuilder: (context, index) {
                      final dataItem = data['items'][index];
                      return Column(
                        children: [
                          Text('${dataItem['productName']}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Количество:'),
                              Text('${dataItem['quantity']}')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Артикул:'),
                              Text('${dataItem['productId']}')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Цена:'),
                              Text('${dataItem['price']}')
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const Text('loading..');
      },
    );
  }
}

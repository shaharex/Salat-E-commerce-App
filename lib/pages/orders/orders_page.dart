import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salat/read%20data/order_info.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final user = FirebaseAuth.instance.currentUser!;

  // document IDs
  List<String> docIDs = [];

  late Future<void> futureDocIds;

  // get docIds
  Future<void> getDocIds() async {
    docIDs.clear();
    await FirebaseFirestore.instance.collection('orders').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    futureDocIds = getDocIds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MaterialButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text('Заказы'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: futureDocIds,
        builder: (context, snapshot) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return GetOrderInfo(documentId: docIDs[index]);
            },
          );
        },
      ),
    );
  }
}

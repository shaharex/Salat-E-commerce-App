import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:salat/firebase_options.dart';
import 'package:salat/models/cart.dart';
import 'package:salat/pages/cart/cart_page.dart';
import 'package:salat/pages/home/home_page.dart';
import 'package:salat/pages/myapp.dart';
import 'package:salat/pages/orders/check_in_page.dart';
import 'package:salat/pages/orders/login_page.dart';
import 'pages/orders/orders_page.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => Cart(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salat E-Commerce App',
      debugShowCheckedModeBanner: false,
      home: MyAppRouter(),
      routes: {
        '/home_page': (context) => HomePage(),
        '/cart_page': (context) => CartPage(),
        '/orders_page': (context) => OrdersPage(),
        '/checkin_page': (context) => CheckInPage(),
        '/login_page': (context) => LoginPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:salat/components/my_drawer.dart';
import 'package:salat/pages/home/home_page.dart';

class MyAppRouter extends StatefulWidget {
  const MyAppRouter({
    super.key,
  });

  @override
  State<MyAppRouter> createState() => _MyAppRouterState();
}

class _MyAppRouterState extends State<MyAppRouter>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              collapsedHeight: 120,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              flexibleSpace: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 30, top: 30),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/logo/salat_logo.png",
                    ),
                  ),
                ],
              ),
              pinned: true,
              floating: false,
              snap: false,
            ),
          ];
        },
        body: HomePage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:online_shop/Widgets/Add_Product.dart';
import 'package:online_shop/models/carts.dart';
import 'package:online_shop/models/orders.dart';
import 'package:online_shop/models/products.dart';
import 'package:online_shop/screens/Cats_Pagescreens.dart';
import 'package:online_shop/screens/Home_Screen.dart';
import 'package:online_shop/screens/Manegment_productsScreen.dart';
import 'package:online_shop/screens/info_productScreen.dart';
import 'package:online_shop/screens/orders_PageScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<productIteam>(
          create: ((context) => productIteam()),
        ),
        ChangeNotifierProvider<cartIteams>(
          create: ((context) => cartIteams()),
        ),
        ChangeNotifierProvider<orderIteams>(
          create: ((context) => orderIteams()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          textTheme: TextTheme(
            bodyMedium: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        routes: {
          "/": (context) => Home_Screen(),
          "InfoProduct": (context) => InfoProductScreen(),
          "CartScreen": (context) => CartPageScreen(),
          "OrderPage": (context) => OrderPageScrren(),
          "Manegment": (context) => ManegmentProductsScreen(),
          "AddProduct": (context) => AddProduct(),
        },
      ),
    );
  }
}

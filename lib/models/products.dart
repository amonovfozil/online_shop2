import 'package:flutter/material.dart';
import 'package:online_shop/models/carts.dart';

class product with ChangeNotifier {
  final String id;
  final String title;
  final String image;
  final String status;
  final String info;
  final double price;
  final int amount;
  final double discount;
  final Color backgarund;
  bool isfavority = false;
  product({
    required this.id,
    required this.title,
    required this.image,
    required this.status,
    required this.info,
    this.amount = 1,
    required this.price,
    required this.backgarund,
    this.discount = 0,
    this.isfavority = false,
  });

  void changefavority() {
    isfavority = !isfavority;
    notifyListeners();
  }
}

class productIteam with ChangeNotifier {
  List<product> _products = [
    product(
      id: 'p1',
      title: 'Macbook Air',
      image: 'assets/images/mac.png',
      status: 'Yangi, 2021-yil, M1 chip, 8/256 SSD ',
      info:
          'ajoyib ,Yangi, tanlovda adashmadingiz, tanlovingizdagi mahsulotlarini bizdan oling, Yangi, 2021-yil, M1 chip, 8/256 SSD ',
      discount: 0,
      price: 889,
      backgarund: Colors.amber,
    ),
    product(
      id: 'p2',
      title: 'IpHone 11 pro ',
      image: 'assets/images/phone.png',
      status: 'Yangi, 8/256 SSD, black/blueGrey ',
      info:
          ' ajoyib ,Yangi, tanlovda adashmadingiz, tanlovingizdagi mahsulotlarini bizdan oling, 8/256 SSD, black/blueGrey ',
      discount: 5,
      price: 1024,
      backgarund: Colors.blueGrey,
    ),
    product(
      id: 'p3',
      title: 'Air Pods',
      image: 'assets/images/pods.png',
      status: 'Yangi, batary 4-5 soat,oq/qora ',
      info:
          'ajoyib ,Yangi, tanlovda adashmadingiz, tanlovingizdagi mahsulotlarini bizdan oling,Yangi, batary 4-5 soat,oq/qora ',
      discount: 15,
      price: 300,
      backgarund: Colors.teal,
    ),
    product(
      id: 'p4',
      title: 'Iwatch Pro',
      image: 'assets/images/watch.png',
      status: 'Yangi, android 11, bluetooth 5.2 ',
      info:
          'ajoyib ,Yangi, tanlovda adashmadingiz, tanlovingizdagi mahsulotlarini bizdan oling,Yangi, android 11, bluetooth 5.2 ',
      discount: 10,
      price: 600,
      backgarund: Colors.grey,
    ),
  ];

  List<product> get list {
    return _products;
  }

  List<product> get favorities {
    return _products.where((product) => product.isfavority).toList();
  }

  void delete(productid) {
    _products.removeWhere((product) => product.id == productid);
    notifyListeners();
  }
}

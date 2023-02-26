import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_shop/models/carts.dart';
import 'package:http/http.dart' as http;
import 'package:string_to_color/string_to_color.dart';

class product with ChangeNotifier {
  final String id;
  final String title;
  final String image;
  final bool status;
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
    this.status = false,
    required this.info,
    this.amount = 1,
    required this.price,
    this.backgarund = Colors.grey,
    this.discount = 0,
    this.isfavority = false,
  });

  void changefavority() {
    isfavority = !isfavority;
    var Url = Uri.parse(
        'https://onlineshop2-3dee7-default-rtdb.firebaseio.com/product/${id}.json');

    http.patch(
      Url,
      body: jsonEncode(
        {"isfavority": isfavority},
      ),
    );
    notifyListeners();
  }
}

class productIteam with ChangeNotifier {
  List<product> _products = [];
  Future<void> getProductFromFireBase() async {
    final url = Uri.parse(
        'https://onlineshop2-3dee7-default-rtdb.firebaseio.com/product.json');

    final respons = await http.get(url);
    if (jsonDecode(respons.body) != null) {
      final dataBase = jsonDecode(respons.body) as Map<String, dynamic>;
      final List<product> _loadingProducts = [];

      dataBase.forEach((productID, products) {
        _loadingProducts.insert(
          0,
          product(
            id: productID,
            title: products['title'],
            image: products['image'],
            info: products['info'],
            price: products['price'],
            backgarund: ColorUtils.stringToColor(products['color']),
            status: products['status'],
            discount: products['discount'],
            isfavority: products['isfavority'],
          ),
        );
      });

      _products = _loadingProducts;
      notifyListeners();
    }
  }

  List<product> get list {
    return _products;
  }

  List<product> get favorities {
    return _products.where((product) => product.isfavority).toList();
  }

  Future<void> AddNewproduct(product Product) {
    var Url = Uri.parse(
        'https://onlineshop2-3dee7-default-rtdb.firebaseio.com/product.json');

    return http
        .post(
      Url,
      body: jsonEncode({
        "id": UniqueKey().toString(),
        "title": Product.title,
        "image": Product.image,
        "info": Product.info,
        "price": Product.price,
        "color": Product.backgarund.toString(),
        "status": Product.status,
        "discount": Product.discount,
        'isfavority': Product.isfavority,
      }),
    )
        .then((respons) {
      _products.add(product(
        id: 'p${_products.length + 1}',
        title: Product.title,
        image: Product.image,
        info: Product.info,
        price: Product.price,
        backgarund: Product.backgarund,
        status: Product.status,
      ));
      notifyListeners();
    });
  }

  Future<void> UpdateProduct(product EditingProduct) async {
    final indexProduct =
        _products.indexWhere((element) => element.id == EditingProduct.id);
    _products[indexProduct] = EditingProduct;

    var Url = Uri.parse(
        'https://onlineshop2-3dee7-default-rtdb.firebaseio.com/product/${EditingProduct.id}.json');

    http.patch(
      Url,
      body: jsonEncode(
        {
          "title": EditingProduct.title,
          "image": EditingProduct.image,
          "info": EditingProduct.info,
          "price": EditingProduct.price,
          "color": EditingProduct.backgarund.toString(),
          "status": EditingProduct.status,
          "discount": EditingProduct.discount,
        },
      ),
    );
    notifyListeners();
  }

  Future<void> delete(productid) async {
    var Url = Uri.parse(
        'https://onlineshop2-3dee7-default-rtdb.firebaseio.com/product/${productid}.json');

    http.delete(Url);

    _products.removeWhere((product) => product.id == productid);
    notifyListeners();
  }
}

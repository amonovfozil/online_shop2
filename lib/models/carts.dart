import 'package:flutter/cupertino.dart';

class Cart {
  final String id;
  final String title;
  final String Photo;
  final Color backgraund;
  final double price;
  final int amount;

  Cart({
    required this.id,
    required this.title,
    required this.Photo,
    required this.backgraund,
    required this.price,
    required this.amount,
  });
}

class cartIteams with ChangeNotifier {
  Map<String, Cart> _Carts = {};

  Map<String, Cart> get list {
    return _Carts;
  }

  int purchases() {
    return _Carts.length;
  }

  double TotalProductPrice() {
    var total = 0.0;

    _Carts.forEach((key, cart) {
      total += cart.amount * cart.price;
    });
    return total;
  }

  void minusAmount(producyID) {
    if (_Carts[producyID]!.amount > 1) {
      _Carts.update(
        producyID,
        (nawCart) => Cart(
          id: nawCart.id,
          title: nawCart.title,
          Photo: nawCart.Photo,
          backgraund: nawCart.backgraund,
          price: nawCart.price,
          amount: nawCart.amount - 1,
        ),
      );
    }

    notifyListeners();
  }

  void AddCart(
    String productId,
    String title,
    String Photo,
    Color backgraundcolor,
    double price,
  ) {
    if (_Carts.containsKey(productId)) {
      // mahsulot sonini ko`paytir
      _Carts.update(
        productId,
        (nowCart) => Cart(
          id: nowCart.id,
          Photo: nowCart.Photo,
          backgraund: nowCart.backgraund,
          title: nowCart.title,
          price: nowCart.price,
          amount: nowCart.amount + 1,
        ),
      );
    } else {
      //mahsulotni _cartga qo`sh
      _Carts.putIfAbsent(
        productId,
        () => Cart(
          id: UniqueKey().toString(),
          title: title,
          Photo: Photo,
          backgraund: backgraundcolor,
          price: price,
          amount: 1,
        ),
      );
    }
    notifyListeners();
  }

  void Delete(cartId) {
    _Carts.remove(cartId);
    notifyListeners();
  }

  void cleanCarts() {
    _Carts.clear();
    notifyListeners();
  }
}

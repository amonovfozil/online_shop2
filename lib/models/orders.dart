import 'package:flutter/cupertino.dart';
import 'package:online_shop/models/carts.dart';

class order {
  final String id;
  final List<Cart> carts;
  final DateTime date;
  final double totalPrice;

  order(
      {required this.id,
      required this.totalPrice,
      required this.carts,
      required this.date});
}

class orderIteams with ChangeNotifier {
  List<order> _orders = [];

  List<order> get list {
    return _orders;
  }

  void addOrder(double totalPrice, List<Cart> carts) {
    _orders.insert(
      0,
      order(
        id: UniqueKey().toString(),
        totalPrice: totalPrice,
        carts: carts,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}

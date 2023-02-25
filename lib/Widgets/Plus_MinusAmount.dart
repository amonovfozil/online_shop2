import 'package:flutter/material.dart';
import 'package:online_shop/models/carts.dart';
import 'package:provider/provider.dart';

class Plus_MinusAmount extends StatelessWidget {
  const Plus_MinusAmount({
    Key? key,
    required this.productid,
    required this.title,
    required this.photo,
    required this.price,
    required this.backgraundcolor,
  }) : super(key: key);

  final String productid;
  final String title;
  final String photo;
  final double price;
  final Color backgraundcolor;

  @override
  Widget build(BuildContext context) {
    final cartiteam = Provider.of<cartIteams>(context);
    final amount = cartiteam.list.containsKey(productid)
        ? cartiteam.list[productid]!.amount
        : 1;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              splashRadius: 25,
              padding: const EdgeInsets.all(0),
              onPressed: () => cartiteam.minusAmount(productid),
              icon: Icon(
                Icons.remove,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              alignment: Alignment.center,
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white.withOpacity(0.7),
              ),
              child: Text(
                amount.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
          ),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              splashRadius: 25,
              padding: const EdgeInsets.all(0),
              onPressed: () => cartiteam.AddCart(
                  productid, title, photo, backgraundcolor, price),
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

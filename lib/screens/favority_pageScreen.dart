import 'package:flutter/material.dart';
import 'package:online_shop/Widgets/Product_iteams.dart';
import 'package:online_shop/models/products.dart';
import 'package:provider/provider.dart';

class FavorityPageScreen extends StatelessWidget {
  const FavorityPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productIteams = Provider.of<productIteam>(context).favorities;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: productIteams.length > 0
          ? GridView.builder(
              itemCount: productIteams.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 330,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: ((context, index) {
                final product = productIteams[index];
                return ProductIteams(
                  products: product,
                  index: index,
                );
              }),
            )
          : const Center(
              child: Text(' Sevimli mahsulotlar Yuq'),
            ),
    );
  }
}

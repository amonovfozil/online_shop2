import 'package:flutter/material.dart';
import 'package:online_shop/Widgets/Product_iteams.dart';
import 'package:online_shop/models/products.dart';
import 'package:provider/provider.dart';

class MagazinPageScreen extends StatelessWidget {
  const MagazinPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productIteams = Provider.of<productIteam>(context).list;
    return productIteams.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
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
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Mahsulotlar mavjud emas',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Center(
                child: Text(
                  ' Iltimos mahsulot qo`shing',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              )
            ],
          );
  }
}

import 'package:flutter/material.dart';
import 'package:online_shop/models/carts.dart';
import 'package:online_shop/models/products.dart';
import 'package:provider/provider.dart';

class ProductIteams extends StatelessWidget {
  const ProductIteams({
    Key? key,
    required this.products,
    required this.index,
  }) : super(key: key);

  final product products;
  final int index;

  @override
  Widget build(BuildContext context) {
    final CartIteam = Provider.of<cartIteams>(context);

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed("InfoProduct", arguments: {
        "product": products,
        "index": index,
      }),
      child: GridTile(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: products.backgarund,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 220,
                  width: 220,
                  child: products.image.startsWith('assets/')
                      ? Image.asset(
                          products.image,
                        )
                      : Image.network(
                          products.image,
                        ),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  Text(
                    "${products.info.substring(0, 30)}...",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        header: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: products.discount != 0
                  ? Chip(
                      backgroundColor: Colors.white,
                      label: Text(
                        '${products.discount}% chegirma',
                        style: TextStyle(color: products.backgarund),
                      ),
                    )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: products.status
                  ? Chip(
                      backgroundColor: Colors.white,
                      label: Text(
                        "Yangi",
                        style: TextStyle(color: products.backgarund),
                      ),
                    )
                  : null,
            ),
          ],
        ),
        footer: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${products.price.toStringAsFixed(0)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Colors.white),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade200),
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () => CartIteam.AddCart(
                      products.id,
                      products.title,
                      products.image,
                      products.backgarund,
                      products.price,
                    ),
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 25,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

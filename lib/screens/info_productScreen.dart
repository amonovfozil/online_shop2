import 'package:flutter/material.dart';
import 'package:online_shop/Widgets/Plus_MinusAmount.dart';
import 'package:online_shop/models/carts.dart';
import 'package:online_shop/models/products.dart';
import 'package:provider/provider.dart';

class InfoProductScreen extends StatefulWidget {
  const InfoProductScreen({super.key});

  @override
  State<InfoProductScreen> createState() => _InfoProductScreenState();
}

class _InfoProductScreenState extends State<InfoProductScreen> {
  @override
  Widget build(BuildContext context) {
    final CartIteam = Provider.of<cartIteams>(context);
    final carts = CartIteam.list;
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final index = data['index'];
    final products = data['product'] as product;
    return Scaffold(
      backgroundColor: products.backgarund,
      appBar: AppBar(
        title: Text(products.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: double.infinity,
                child: Image.asset(
                  products.image,
                  width: 100,
                  height: 220,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   child:
              // )
            ],
          ),
          Plus_MinusAmount(
            productid: products.id,
            title: products.title,
            photo: products.image,
            price: products.price,
            backgraundcolor: products.backgarund,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                index == 0 ? 'Yangi' : '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: products.backgarund),
                              ),
                            ],
                          ),
                          IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                products.changefavority();
                              });
                            },
                            icon: Icon(
                              products.isfavority
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Xarakteristika',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Card(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            products.info,
                            style: TextStyle(
                                fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Umumiy Narxi:',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "\$${products.amount * products.price}",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: products.backgarund),
                    )
                  ],
                ),
                carts.containsKey(products.id)
                    ? ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('CartScreen'),
                        child: Text('Savatchaga kirish'),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            backgroundColor: Colors.blueGrey.shade200),
                      )
                    : ElevatedButton(
                        onPressed: () => CartIteam.AddCart(
                          products.id,
                          products.title,
                          products.image,
                          products.backgarund,
                          products.price,
                        ),
                        child: Text('Savatchaga Qo`shish'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
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

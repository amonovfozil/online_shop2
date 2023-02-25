import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:online_shop/Widgets/Plus_MinusAmount.dart';
import 'package:online_shop/models/carts.dart';
import 'package:online_shop/models/orders.dart';
import 'package:provider/provider.dart';

class CartPageScreen extends StatelessWidget {
  const CartPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartIteam = Provider.of<cartIteams>(context);
    final orders = Provider.of<orderIteams>(context);

    final carts = CartIteam.list.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Savatcha',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => CartIteam.cleanCarts(),
            child: Text(
              'Tozalash',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
      body: carts.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: carts.length,
                itemBuilder: ((context, index) {
                  final cart = carts[index];

                  final productId = CartIteam.list.keys.toList()[index];
                  return Slidable(
                    key: ValueKey(productId),
                    endActionPane: ActionPane(
                        extentRatio: 0.32,
                        motion: ScrollMotion(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () => CartIteam.Delete(productId),
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).errorColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 28),
                              ),
                            ),
                          )
                        ]),
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: cart.backgraund,
                          ),
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            cart.Photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          cart.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          '\$${cart.amount * cart.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        trailing: Plus_MinusAmount(
                          productid: productId,
                          title: cart.title,
                          photo: cart.Photo,
                          price: cart.price,
                          backgraundcolor: cart.backgraund,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )
          : const Center(
              child: Text('Xaridlaringiz mavjud emas'),
            ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey.shade50,
        child: Container(
          height: 85,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Umumiy Narxi:',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "\$${CartIteam.TotalProductPrice()}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: CartIteam.TotalProductPrice() != 0
                        ? () {
                            orders.addOrder(
                                CartIteam.TotalProductPrice(), carts);
                            print(orders.list);
                            CartIteam.cleanCarts();
                            Navigator.of(context)
                                .pushReplacementNamed('OrderPage');
                          }
                        : null,
                    child: Text(
                        'Xarid Qilish  \$${CartIteam.TotalProductPrice()}'),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 20),
                        backgroundColor: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

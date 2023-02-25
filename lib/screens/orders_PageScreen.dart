import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/Widgets/Side_bar.dart';
import 'package:online_shop/models/orders.dart';
import 'package:provider/provider.dart';

class OrderPageScrren extends StatelessWidget {
  const OrderPageScrren({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<orderIteams>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Byurmalar'),
        centerTitle: true,
      ),
      drawer: SideBar(),
      body: orders.list.isNotEmpty
          ? ListView.builder(
              itemCount: orders.list.length,
              itemBuilder: ((context, index) {
                final order = orders.list[index];
                return Card(
                  child: ExpansionTile(
                    title: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: order.id,
                              style: TextStyle(color: Colors.teal)),
                          TextSpan(
                            text: "  \$${order.totalPrice}",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ])),
                    subtitle: Text(
                      DateFormat('d-mm-yyyy, hh:mm ').format(order.date),
                    ),
                    children: order.carts
                        .map(
                          (cart) => ListTile(
                            leading: cart.Photo.startsWith('assets/')
                                ? CircleAvatar(
                                    radius: 25,
                                    backgroundColor: cart.backgraund,
                                    backgroundImage: AssetImage(cart.Photo),
                                  )
                                : CircleAvatar(
                                    radius: 25,
                                    backgroundColor: cart.backgraund,
                                    backgroundImage: NetworkImage(cart.Photo),
                                  ),
                            title: Text(
                              cart.title,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              "\$${cart.price}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              'x ${cart.amount}',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }),
            )
          : const Center(
              child: Text('Buyurmalarinigiz mavjud emas'),
            ),
    );
  }
}

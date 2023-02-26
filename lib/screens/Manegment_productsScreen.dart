import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:online_shop/Widgets/Side_bar.dart';
import 'package:online_shop/models/products.dart';
import 'package:provider/provider.dart';

class ManegmentProductsScreen extends StatelessWidget {
  const ManegmentProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productiteams = Provider.of<productIteam>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahsulotlarni Boshqarish'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('AddProduct'),
            icon: Icon(
              Icons.add_chart_outlined,
            ),
          ),
        ],
      ),
      drawer: SideBar(),
      body: productiteams.list.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: productiteams.list.length,
                itemBuilder: ((context, index) {
                  final product = productiteams.list[index];
                  return Card(
                    child: ListTile(
                        leading: product.image.startsWith('assets/')
                            ? CircleAvatar(
                                radius: 25,
                                backgroundColor: product.backgarund,
                                backgroundImage: AssetImage(product.image),
                              )
                            : CircleAvatar(
                                radius: 25,
                                backgroundColor: product.backgarund,
                                backgroundImage: NetworkImage(product.image),
                              ),
                        title: Text(
                          product.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pushNamed(
                                  'AddProduct',
                                  arguments: product.id),
                              icon: Icon(
                                Icons.edit,
                                size: 22,
                              ),
                              splashRadius: 25,
                            ),
                            IconButton(
                              onPressed: () => productiteams.delete(product.id),
                              icon: Icon(
                                Icons.delete_outline,
                                size: 25,
                              ),
                              splashRadius: 25,
                            )
                          ],
                        )),
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
                    ' Iltimos Mahsulot Qo`shing',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
    );
  }
}

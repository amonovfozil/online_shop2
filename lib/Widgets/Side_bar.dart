import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  Widget CreatMenuIteam(
      BuildContext context, String title, IconData iconn, String adrres) {
    return Card(
      child: InkWell(
        // splashColor: Theme.of(context).primaryColor,
        onTap: () => Navigator.of(context).pushReplacementNamed(adrres),
        child: ListTile(
          leading: Icon(iconn),
          title: Text(title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            CreatMenuIteam(context, 'Bosh Sahifa', Icons.home, '/'),
            CreatMenuIteam(context, 'Byutmalar', Icons.shopify, 'OrderPage'),
            CreatMenuIteam(context, 'Mahsulotlarni Boshqarish', Icons.settings,
                'Manegment'),
          ],
        ),
      ),
    );
  }
}

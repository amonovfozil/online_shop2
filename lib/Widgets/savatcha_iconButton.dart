import 'package:flutter/material.dart';
import 'package:online_shop/models/carts.dart';
import 'package:provider/provider.dart';

class SavatchaIconButton extends StatelessWidget {
  const SavatchaIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final CartIteam = Provider.of<cartIteams>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => Navigator.of(context).pushNamed('CartScreen'),
            icon: Icon(
              Icons.add_shopping_cart_rounded,
              size: 25,
            ),
          ),
          Positioned(
            top: 2,
            right: 6,
            child: CartIteam.purchases() != 0
                ? Container(
                    alignment: Alignment.center,
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red),
                    child: Text(
                      CartIteam.purchases().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                      ),
                    ),
                  )
                : Text(''),
          )
        ],
      ),
    );
  }
}

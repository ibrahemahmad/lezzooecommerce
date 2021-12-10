import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/view/products/list_card_view.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({
    Key? key,
    required this.myTheme,
  }) : super(key: key);

  final MyTheme myTheme;

  @override
  Widget build(BuildContext context) {
    return Selector<RootProvider, int>(
      selector: (_, dat) => dat.listOrder.length,
      builder: (context, value, child) {
        return Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListCardView(),
                  ),
                );
              },
              child: Icon(Icons.shopping_cart),
              backgroundColor: myTheme.mainColor,
            ),
            CircleAvatar(
              radius: 12,
              backgroundColor: myTheme.lezzooColors,
              child: Text(
                "${value}",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }
}

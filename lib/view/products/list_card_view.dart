import 'package:ecommerce/controller/locator.dart';
import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/model/order_model.dart';
import 'package:ecommerce/view/widgets/list_product_card.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCardView extends StatefulWidget {
  @override
  _ListCardViewState createState() => _ListCardViewState();
}

class _ListCardViewState extends State<ListCardView> {
  MyTheme myTheme = locator<MyTheme>();
  RootProvider rootProvider = locator<RootProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myTheme.secondColor,
      appBar: AppBar(
        title: Text(
          "Carts",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: myTheme.mainColor,
      ),
      body: Consumer<RootProvider>(
        builder: (context, value, child) {
          if (value.listOrder.length > 0) {
            return ListView.builder(
              itemCount: value.listOrder.length,
              itemBuilder: (context, index) {
                OrderModel orderModel = value.listOrder[index];
                return ListProductCard(
                  productModel: orderModel.productModel,
                  countNum: orderModel.numberProduct,
                  isCard: true,
                );
              },
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/bankrupt.png",
                      height: 100,
                    ),
                    Text("your cart is empty!"),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

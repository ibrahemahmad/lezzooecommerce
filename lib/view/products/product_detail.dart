import 'package:ecommerce/controller/locator.dart';
import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/model/order_model.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/model/store_model.dart';
import 'package:ecommerce/view/widgets/floating_cart_button.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel? productModel;
  final StoreModel? storeModel;

  ProductDetail({@required this.productModel, @required this.storeModel});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  MyTheme myTheme = locator<MyTheme>();
  RootProvider rootProvider = locator<RootProvider>();
  int _countOrder = 1;

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = widget.productModel!;
    Size scSize = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingCartButton(myTheme: myTheme),
      backgroundColor: myTheme.secondColor,
      appBar: AppBar(
        title: Text(
          "${widget.productModel!.name}",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: myTheme.mainColor,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 300,
            decoration: new BoxDecoration(
                color: myTheme.colorConvert(color: productModel.bgColors!),
                borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.circular(50.0),
                  bottomLeft: new Radius.circular(50.0),
                ),
                image: new DecorationImage(
                    image: new NetworkImage(productModel.imageUrl!),
                    fit: BoxFit.fitHeight)),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 300, left: 8, right: 8),
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                  color: myTheme.mainColor.withAlpha(180),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                productModel.name!,
                                style: textTheme.headline6!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "price",
                                style: textTheme.headline6!
                                    .copyWith(color: Colors.redAccent),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                productModel.price!,
                                style: textTheme.headline6!
                                    .copyWith(color: Colors.redAccent),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(top: 10, bottom: 40),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      productModel.description!,
                      style: textTheme.subtitle2,
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () => changeOrderNumber(type: 0),
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                        shape: CircleBorder(),
                      ),
                      Text(
                        "${_countOrder}",
                        style: textTheme.headline5!
                            .copyWith(color: Colors.redAccent),
                      ),
                      MaterialButton(
                        onPressed: () => changeOrderNumber(type: 1),
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: MaterialButton(
                      minWidth: (scSize.width / 4) * 3,
                      onPressed: () {
                        rootProvider.addProductIntoCard(OrderModel(
                            numberProduct: _countOrder,
                            productModel: productModel));
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Submit",
                          style:
                              textTheme.button!.copyWith(color: Colors.white),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // 1 to add 0 to remove
  changeOrderNumber({int type = 1}) {
    if (type == 1) {
      setState(() {
        _countOrder++;
      });
    } else if (type == 0) {
      if (_countOrder > 1) {
        setState(() {
          _countOrder--;
        });
      }
    }
  }
}

import 'package:ecommerce/controller/locator.dart';
import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/model/category_model.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/model/store_model.dart';
import 'package:ecommerce/view/products/product_detail.dart';
import 'package:ecommerce/view/widgets/floating_cart_button.dart';
import 'package:ecommerce/view/widgets/list_product_card.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final StoreModel? storeModel;

  ProductScreen({@required this.storeModel});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  MyTheme myTheme = locator<MyTheme>();
  RootProvider rootProvider = locator<RootProvider>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) async {
      await rootProvider.addDataIntoListProductAsStore(widget.storeModel!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingCartButton(myTheme: myTheme),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor:
                  myTheme.colorConvert(color: widget.storeModel!.bgColors!),
              expandedHeight: 200.0,
              title: Text(
                widget.storeModel!.name!,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: myTheme.mainColor),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 44, 30, 5),
                  child: Image.asset(
                    widget.storeModel!.imageUrl!,
                    fit: BoxFit.fitHeight,
                    width: (scSize.width / 4) * 2,
                  ),
                ),
              ),
              pinned: true,
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 15),
                  child: IconButton(
                    onPressed: filterBtn,
                    alignment: Alignment.center,
                    splashRadius: 1,
                    icon: Icon(
                      Icons.settings_input_component,
                      size: 30,
                      color: myTheme.mainColor,
                    ),
                  ),
                )
              ],
              leading: BackButton(
                color: myTheme.mainColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Consumer<RootProvider>(
              builder: (context, value, child) {
                if (value.listProductSearch.length > 0) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                        ProductModel product = value.listProductSearch[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                    productModel: product,
                                    storeModel: widget.storeModel),
                              ),
                            );
                          },
                          child: ListProductCard(
                            productModel: product,
                          ),
                        );
                      },
                      childCount: value.listProductSearch.length,
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                        ProductModel product = value.listProductAsStore[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                    productModel: product,
                                    storeModel: widget.storeModel),
                              ),
                            );
                          },
                          child: ListProductCard(
                            productModel: product,
                          ),
                        );
                      },
                      childCount: value.listProductAsStore.length,
                    ),
                  );
                }
              },
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 10),
            )
          ],
        ),
      ),
    );
  }

  filterBtn() async {
    if (rootProvider.listCategory.length < 1) {
      return;
    } else {
      List<CategoryModel> currentCategory = rootProvider.listCategory
          .where((element) => element.idStore == widget.storeModel!.id)
          .toList();
      if (currentCategory.length > 0) {
        rootProvider.categoryCheckBox(currentCategory);
      }
    }
  }
}


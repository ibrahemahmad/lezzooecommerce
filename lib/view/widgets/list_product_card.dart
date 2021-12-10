import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/locator.dart';
import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/model/category_model.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/model/store_model.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';

MyTheme myTheme = locator<MyTheme>();
RootProvider rootProvider = locator<RootProvider>();

class ListProductCard extends StatelessWidget {
  const ListProductCard(
      {@required this.productModel, this.isCard = false, this.countNum = 0});

  final ProductModel? productModel;
  final bool? isCard;
  final int? countNum;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Card(
        color: myTheme.secondColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: myTheme.colorConvert(color: productModel!.bgColors),
                width: 1)),
        elevation: 4,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsetsDirectional.only(
                      start: 6,
                    ),
                    height: 150,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        productModel!.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: "${productModel!.imageUrl}",
                                imageBuilder: (context, imageProvider) =>
                                    Center(
                                  child: Container(
                                    height: 150,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Center(
                                    child: Icon(
                                  Icons.person_outline,
                                  size: 80,
                                )),
                              )
                            : Image.asset(
                                "assets/lez_log.png",
                                fit: BoxFit.cover,
                                height: 150,
                                width: 130,
                              ),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: myTheme.mainColor.withAlpha(120),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Text(
                            "${productModel!.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 148,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${productModel!.name} ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          "${getCategoryById(productModel!.idCategory)}",
                          style: textTheme.caption,
                        ),
                        productModel!.description!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 6, end: 3),
                                child: Text(
                                  '${productModel!.description!}',
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.justify,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            isCard! && countNum! > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.green,
                          child: Text(
                            "${countNum!}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          rootProvider.removeProductFromCard(productModel!.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: myTheme.lezzooColors,
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  getCategoryById(id) {
    CategoryModel nameCategory =
        rootProvider.listCategory.where((element) => element.id == id).first;
    return nameCategory.name;
  }
}

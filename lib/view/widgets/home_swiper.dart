import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/model/store_model.dart';
import 'package:ecommerce/view/products/product_view.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeSwiper extends StatelessWidget {
  const HomeSwiper({
    Key? key,
    required this.rootProvider,
    required this.myTheme,
    required this.scSize,
  }) : super(key: key);

  final RootProvider rootProvider;
  final MyTheme myTheme;
  final Size scSize;

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        StoreModel storeModel = rootProvider.listStore[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(storeModel: storeModel),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: myTheme.colorConvert(color: storeModel.bgColors!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    storeModel.imageUrl!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Text(
                  "${storeModel.name}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        );
      },
      itemCount: rootProvider.listStore.length,
      itemWidth: scSize.height > 500 && scSize.width > 330 ? 300 : 200,
      itemHeight: scSize.height > 500 && scSize.width > 330 ? 400 : 300,
      layout: SwiperLayout.STACK,
    );
  }
}

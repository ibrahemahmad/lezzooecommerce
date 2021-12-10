import 'package:ecommerce/controller/locator.dart';
import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/view/widgets/floating_cart_button.dart';
import 'package:ecommerce/view/widgets/home_app_bar.dart';
import 'package:ecommerce/view/widgets/home_swiper.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyTheme myTheme = locator<MyTheme>();
  RootProvider rootProvider = locator<RootProvider>();

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingCartButton(myTheme: myTheme),
        backgroundColor: myTheme.secondColor,
        body: Column(
          children: [
            HomeAppbar(myTheme: myTheme),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "choose your\nfavourite".toUpperCase(),
                          style:textTheme.headline4 ,
                          textAlign:TextAlign.center,
                        ),
                      ),
                      rootProvider.listStore.length > 1
                          ? HomeSwiper(
                          rootProvider: rootProvider,
                          myTheme: myTheme,
                          scSize: scSize)
                          : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/bankrupt.png",
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                              Text(
                                "No stores found",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await rootProvider
                                      .addTestDataIntoStateManagement();
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  size: 30,
                                ),
                                splashRadius: 22,
                              )
                            ],
                          )),
                    ],
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

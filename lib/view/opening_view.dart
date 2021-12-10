import 'package:ecommerce/controller/locator.dart';
import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'home_page.dart';

class OpeningView extends StatefulWidget {
  @override
  _OpeningViewState createState() => _OpeningViewState();
}

class _OpeningViewState extends State<OpeningView> {
  MyTheme myTheme = locator<MyTheme>();
  RootProvider rootProvider = locator<RootProvider>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) async {
      //if you want you can get some data from server when user locking into this opening screen.
      await rootProvider.addTestDataIntoStateManagement();
      await Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.pushAndRemoveUntil(
            navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (Route<dynamic> route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: myTheme.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/Lezzoo_Logo.png",
                fit: BoxFit.fitWidth,
                width: (scSize.width/4)*3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 25),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: myTheme.lezzooColors,
                ),
              ),
            ),
            Text(
              "Welcome To Lezzoo",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}

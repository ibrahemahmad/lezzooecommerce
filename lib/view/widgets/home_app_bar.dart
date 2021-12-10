import 'package:ecommerce/view/about/about_view.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';
class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    Key? key,
    required this.myTheme,
  }) : super(key: key);

  final MyTheme myTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/lez_log.png",
              height: 100,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 20, bottom: 10),
              child: Text(
                "Lezzoo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: myTheme.lezzooColors,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 20),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ),
                );
              },
              alignment: Alignment.center,
              splashRadius: 1,
              icon: Icon(
                Icons.info_outline,
                size: 50,
                color: myTheme.mainColor,
              )),
        )
      ],
    );
  }
}

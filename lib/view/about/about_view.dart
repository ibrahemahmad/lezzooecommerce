import 'package:ecommerce/controller/locator.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  MyTheme myTheme = locator<MyTheme>();

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: myTheme.secondColor,
      appBar: AppBar(
        title: Text(
          "About",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: myTheme.mainColor,
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/Lezzoo_Logo.png",
                  fit: BoxFit.fitWidth,
                  width: (scSize.width / 4) * 3,
                ),
              ),
              Text(
                "Lezzoo e-commerce".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

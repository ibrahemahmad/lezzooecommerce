import 'package:ecommerce/controller/locator.dart';
import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/model/category_model.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<void> showSearchAlert(List<CategoryModel> listCategory) async {
  MyTheme myTheme = locator<MyTheme>();
  RootProvider rootProvider = locator<RootProvider>();
  rootProvider.btnCleanOrApply();
  var b = await Alert(
    style: AlertStyle(
        overlayColor: Colors.grey.withOpacity(0.4), isCloseButton: false),
    context: navigatorKey.currentContext!,
    title: "Filter",
    onWillPopActive: false,
    content: Form(
      child: Column(children: [
        Consumer<RootProvider>(
          builder: (context, value, child) {
            return Column(
              children: value.listCheckBox
                  .map<Row>((e) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: e.active,
                              onChanged: (val) {
                                rootProvider.changeCheckBox(e.id!, val!);
                              }),
                          Text(e.name!)
                        ],
                      ))
                  .toList(),
            );
          },
        )
      ]),
    ),
    buttons: [
      DialogButton(
        radius: BorderRadius.circular(20),
        child: Selector<RootProvider, bool>(
          selector: (_, dat) => dat.cleanOrApply,
          builder: (context, value, child) => Text(
            value ? "clean filter" : "Apply filter",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        onPressed: () {
          rootProvider.applySearch();
          Navigator.pop(navigatorKey.currentContext!);
        },
        color: myTheme.mainColor,
      ),
    ],
  ).show();
}

class CheckBoxModel {
  String? name;
  bool? active;
  int? id;

  CheckBoxModel({this.name, this.active, this.id});
}

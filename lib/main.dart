import 'package:ecommerce/controller/locator.dart';
import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/view/home_page.dart';
import 'package:ecommerce/view/opening_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  RootProvider rootProvider = locator<RootProvider>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: rootProvider),
      ],
      child: MaterialApp(
        title: 'Lezzoo',
        debugShowCheckedModeBanner: false,
        home: OpeningView(),
        navigatorKey: navigatorKey,
        theme: ThemeData.light().copyWith(
          //apply rudaw font into all text.
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'Arial',
              ),
          primaryTextTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'Arial',
              ),
          accentTextTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'Arial',
              ),
        ),
      ),
    );
  }
}

// because of this navigatorKey you can access into context from all file in this project.
final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: DateTime.now().toIso8601String());

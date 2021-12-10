import 'package:ecommerce/controller/root_provider.dart';
import 'package:ecommerce/view/widgets/my_theme.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
//after lunch application create on object from each one , during application run.
void setupLocator() async {
  locator.registerSingleton(MyTheme());
  locator.registerSingleton(RootProvider());
}

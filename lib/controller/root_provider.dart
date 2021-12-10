import 'package:ecommerce/main.dart';
import 'package:ecommerce/model/category_model.dart';
import 'package:ecommerce/model/order_model.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/model/store_model.dart';
import 'package:ecommerce/view/widgets/search_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


///using only one Provider class for all process , because of size task.
class RootProvider with ChangeNotifier {
  List<ProductModel> listProduct = [];
  List<ProductModel> listProductSearch = [];
  List<ProductModel> listProductAsStore = [];

  addAllToListProduct(List<ProductModel> value) {
    listProduct = value;
  }

  List<StoreModel> listStore = [];

  addAllToListStore(List<StoreModel> value) {
    listStore = value;
  }

  List<CategoryModel> listCategory = [];

  addAllToListCategory(List<CategoryModel> value) {
    listCategory = value;
  }

  addDataIntoListProductAsStore(int storeId) {
    listProductSearch = [];
    listProductAsStore =
        listProduct.where((element) => element.idStore == storeId).toList();
    notifyListeners();
  }

  //start search operation
  List<CheckBoxModel> listCheckBox = [];

  changeCheckBox(int index, bool val) {
    int catIndex = listCheckBox.indexWhere((element) => element.id == index);
    listCheckBox[catIndex].active = val;
    btnCleanOrApply();
    notifyListeners();
  }

  //for alert button state.
  bool cleanOrApply = true;

  btnCleanOrApply() {
    List check =
        listCheckBox.where((element) => element.active == true).toList();
    if (check.length > 0) {
      cleanOrApply = false;
      notifyListeners();
    } else {
      cleanOrApply = true;
    }
  }

  Future<void> categoryCheckBox(
      List<CategoryModel> listCategoryCurrentStore) async {
    listCheckBox = [];
    listCategoryCurrentStore.forEach((element) {
      listCheckBox.add(
          CheckBoxModel(name: element.name, active: false, id: element.id));
    });
    await showSearchAlert(listCategoryCurrentStore);
  }

  applySearch() {
    listProductSearch = [];
    List<CategoryModel> requarCategory = [];
    for (CheckBoxModel checked in listCheckBox) {
      if (checked.active!) {
        CategoryModel categoryModel =
            listCategory.where((element) => element.id == checked.id).first;
        requarCategory.add(categoryModel);
      }
    }
    if (requarCategory.length > 0) {
      requarCategory.forEach((rqCat) {
        List<ProductModel> tempList = listProductAsStore
            .where((element) => element.idCategory == rqCat.id)
            .toList();
        if (tempList.length > 0) {
          listProductSearch.addAll(tempList);
        }
      });
    }
    if (listProductSearch.length < 1) {
      _showToast("sorry we can't find product fot this category");
    }

    notifyListeners();
  }

  //end search operation

  ///card operations.
  List<OrderModel> listOrder = [];

  addProductIntoCard(OrderModel orderModel) {
    //remove if exist
    listOrder.removeWhere(
        (element) => element.productModel!.id == orderModel.productModel!.id);

    //add .
    listOrder.add(orderModel);
    notifyListeners();
  }

  removeProductFromCard(id) {
    listOrder.removeWhere((element) => element.productModel!.id == id);
    notifyListeners();
  }

  ///end Card

  void _showToast(String text) {
    final scaffold = ScaffoldMessenger.of(navigatorKey.currentContext!);
    scaffold.showSnackBar(
      SnackBar(
        content: Text("$text"),
        duration: Duration(seconds: 4),
      ),
    );
  }

  Future<void> addTestDataIntoStateManagement() async {
    //TODO : this data is only for show, and not real data.
    // from here i will using loop for create a fake data.
    List<StoreModel> store = [
      StoreModel(
        id: 1,
        bgColors: "FDD970",
        name: "Versace",
        imageUrl: "assets/versace.png",
      ),
      StoreModel(
        id: 2,
        bgColors: "D7D7D7",
        name: "Nike",
        imageUrl: "assets/nike.png",
      ),
    ];
    List<CategoryModel> category = [
      CategoryModel(
          id: 1,
          idStore: 1,
          name: "Sweatshirt",
          imageUrl: "assets/sweatshirt.png",
          bgColors: "DEDCD9"),
      CategoryModel(
          id: 2,
          idStore: 1,
          name: "jackets & coats",
          imageUrl: "assets/jacket.png",
          bgColors: "B2DAE3"),
      CategoryModel(
          id: 3,
          idStore: 1,
          name: "Bag",
          imageUrl: "assets/bag.png",
          bgColors: "E3E1B1"),
      CategoryModel(
        id: 4,
        idStore: 2,
        name: "Sport Shoe",
        imageUrl: "assets/sport-shoe.png",
        bgColors: "D2ECC8",
      ),
      CategoryModel(
        id: 5,
        idStore: 2,
        name: "High hell",
        imageUrl: "assets/high-heel.png",
        bgColors: "D74B4B",
      ),
      CategoryModel(
          id: 6,
          idStore: 2,
          name: "Jordan",
          imageUrl: "assets/sneakers.png",
          bgColors: "BAD7D0"),
    ];
    List<ProductModel> product = [
      ProductModel(
          id: 1,
          idStore: 1,
          idCategory: 1,
          bgColors: "D7D7D7",
          name: "La Greca Sweatshirt",
          imageUrl:
              "https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dw22260630/original/90_1003625-1A02503_5U040_10_LaGrecaJumper-Sweatshirts-versace-online-store_0_2.jpg",
          description:
              "Easily dressed up or down, this relaxed sweatshirt features the La Greca print - a pattern ",
          price: "100\$"),
      ProductModel(
          id: 2,
          idStore: 1,
          idCategory: 1,
          bgColors: "D7D7a2",
          name: "Log Sweatshirt",
          imageUrl:
              "https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dwa6e631ed/original/90_1002913-1A02102_2U850_10_LogoSweatshirt-Sweatshirts-versace-online-store_0_1.jpg",
          description:
              "The Versace logo across the collar provides subtle branding to this zipped sweatshirt with elasticated cuffs and hem.",
          price: "100\$"),
      ProductModel(
          id: 3,
          idStore: 1,
          idCategory: 2,
          bgColors: "D7D7b1",
          name: "La Greca Jacket",
          imageUrl:
              "https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dwaaa13545/original/90_1004027-1A02917_2B820_10_LaGrecaJacket-Jackets-versace-online-store_0_2.jpg",
          description:
              "The La Greca print is a striking detail across this zipped jacket. It features a front zip closure with high neck, ",
          price: "1200\$"),
      ProductModel(
          id: 4,
          idStore: 1,
          idCategory: 2,
          bgColors: "D7D7cc",
          name: "Medusa Shirt",
          imageUrl:
              "https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dw4aa9c128/original/90_1004062-1A01703_1B000_10_MedusaShirt-Jackets-versace-online-store_1_0.jpg",
          description:
              "Easily dressed up or down, this relaxed sweatshirt features the La Greca print - a pattern ",
          price: "100\$"),
      ProductModel(
          id: 5,
          idStore: 2,
          idCategory: 5,
          bgColors: "D7D7cc",
          name: "Nike Air Huarache",
          imageUrl:
              "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,b_rgb:f5f5f5/d3249491-4732-47e2-81d6-c087bc120f48/air-huarache-shoes-2q1w46.png",
          description:
              "Built to fit your foot and designed for comfort, the Nike Air Huarache brings back",
          price: "200\$"),
    ];

    addAllToListStore(store);
    addAllToListCategory(category);
    List<ProductModel> listProductsModelFake =
        await addFakeProductIntoList(category);
    product.addAll(listProductsModelFake);
    addAllToListProduct(product);

    notifyListeners();
  }

  Future<List<ProductModel>> addFakeProductIntoList(
      List<CategoryModel> categoryList) async {
    List<ProductModel> tempListProducts = [];
    categoryList.forEach((element) {
      for (int i = 6; i < 50; i++) {
        tempListProducts.add(ProductModel(
          name: "Fake Product ${i}${element.id}",
          id: i,
          price: "${i}0",
          description: "product descriptions ${i}${element.id}",
          imageUrl: "https://picsum.photos/200/300",
          bgColors: "",
          idCategory: element.id,
          idStore: element.idStore,
        ));
      }
    });
    return tempListProducts;
  }
}

class ProductModel {
  int? id;
  String? name;
  String? imageUrl;
  String? price;
  String? description;
  String? bgColors;
  int? idCategory;
  int? idStore;

  ProductModel(
      {this.id,
      this.name,
      this.imageUrl,
      this.price,
      this.description,
      this.bgColors,
      this.idStore,
      this.idCategory});
}

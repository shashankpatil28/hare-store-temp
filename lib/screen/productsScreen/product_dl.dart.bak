// Path: lib/screen/productsScreen/product_dl.dart

import 'package:json_annotation/json_annotation.dart';

part 'product_dl.g.dart';

@JsonSerializable(createToJson: true, includeIfNull: false, fieldRename: FieldRename.snake, explicitToJson: true)
class ProductResponse {
  int status = 0;
  int messageCode = 0;
  String message = "";
  List<ProductList> productList = [];

  ProductResponse({this.status = 0, this.messageCode = 0, this.message = "", List<ProductList>? productList}) {
    this.productList = productList ?? [];
  }

  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable(createToJson: true, includeIfNull: false, fieldRename: FieldRename.snake, explicitToJson: true)
class ProductList {
  int categoryId;
  String categoryName;
  List<Products> products = [];

  ProductList({this.categoryId = 0, this.categoryName = "", List<Products>? products}) {
    this.products = products ?? [];
  }

  factory ProductList.fromJson(Map<String, dynamic> json) => _$ProductListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListToJson(this);
}

@JsonSerializable(createToJson: true, includeIfNull: false, fieldRename: FieldRename.snake, explicitToJson: true)
class Products {
  int productId;
  int productStatus;
  double productPrice;
  String productName;
  String productImage;

  Products({this.productId = 0, this.productStatus = 0, this.productPrice = 0, this.productName = "", this.productImage = ""});

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}

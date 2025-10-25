// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      status: (json['status'] as num?)?.toInt() ?? 0,
      messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
      message: json['message'] as String? ?? "",
      productList: (json['product_list'] as List<dynamic>?)
          ?.map((e) => ProductList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message_code': instance.messageCode,
      'message': instance.message,
      'product_list': instance.productList.map((e) => e.toJson()).toList(),
    };

ProductList _$ProductListFromJson(Map<String, dynamic> json) => ProductList(
  categoryId: (json['category_id'] as num?)?.toInt() ?? 0,
  categoryName: json['category_name'] as String? ?? "",
  products: (json['products'] as List<dynamic>?)
      ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'products': instance.products.map((e) => e.toJson()).toList(),
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
  productId: (json['product_id'] as num?)?.toInt() ?? 0,
  productStatus: (json['product_status'] as num?)?.toInt() ?? 0,
  productPrice: (json['product_price'] as num?)?.toDouble() ?? 0,
  productName: json['product_name'] as String? ?? "",
  productImage: json['product_image'] as String? ?? "",
);

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
  'product_id': instance.productId,
  'product_status': instance.productStatus,
  'product_price': instance.productPrice,
  'product_name': instance.productName,
  'product_image': instance.productImage,
};

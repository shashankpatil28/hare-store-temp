// Path: lib/screen/productsScreen/product_bloc.dart

import 'package:flutter/material.dart'; // Use Material import
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import 'product_dl.dart';
import 'product_repo.dart';
import 'product_screen.dart';

class ProductBloc extends Bloc {
  String tag = "ProductBloc>>>";
  BuildContext context;
  final ProductRepo _repo = ProductRepo();
  State<ProductScreen> state;

  ProductBloc(this.context, this.state) {
    getProductList();
  }

  // Use BehaviorSubject to hold the latest list state
  final productListSubject = BehaviorSubject<ApiResponse<ProductResponse>>();
  // Use BehaviorSubject to emit updates for individual products
  // Keyed by product ID might be complex; simpler to emit the updated product
  // and let the UI find it. Consider using a Map<int, BehaviorSubject> if
  // individual product loading states are needed.
  final productUpdateSubject = BehaviorSubject<ApiResponse<Products>>();

  // Stream for the UI to listen to individual product updates
  Stream<ApiResponse<Products>> get productUpdateStream => productUpdateSubject.stream;

  // Function to add updates to the product stream
  // (Removed setProduct getter to avoid confusion with internal BehaviorSubject)
  // Function(ApiResponse<Products>) get setProduct => productUpdateSubject.sink.add;

  getProductList() async {
    if (productListSubject.isClosed) return;
    productListSubject.sink.add(ApiResponse.loading('fetching details...')); // Use localized string
    try {
      ProductResponse response = ProductResponse.fromJson(await _repo.getProductList());
      if (!state.mounted) return; // Check mounted after await

      String message = response.message;
      // Pass false for isLogout
      if (isApiStatus(context, response.status, message, false)) {
         if (response.productList.isNotEmpty) {
            productListSubject.sink.add(ApiResponse.completed(response));
         } else {
            productListSubject.sink.add(ApiResponse.error('No data available')); // Specific empty message
         }
      } else {
         // isApiStatus might handle UI, update stream state
         productListSubject.sink.add(ApiResponse.error(message));
         // openSimpleSnackbar(message); // Might be redundant
      }

    } catch (e) {
      if (!state.mounted) return;
       String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
      productListSubject.sink.add(ApiResponse.error(errorMessage));
      logd(tag, "Get Product List Error: $e");
       openSimpleSnackbar(errorMessage); // Show error
    }
  }

  updateProductStatus(Products product, int status) async {
    if (productUpdateSubject.isClosed) return;
    // Emit loading state specifically for the product being updated
    productUpdateSubject.sink.add(ApiResponse.loading('', product));
    try {
      BaseModel response = BaseModel.fromJson(await _repo.updateProduct(productId: product.productId, productStatus: status));

      if (!state.mounted) return; // Check mounted after await

      var apiMsg = getApiMsg(context, response.message, response.messageCode);

      // Pass false for isLogout
      if (isApiStatus(context, response.status, apiMsg, false)) {
        // Update the product object locally *before* emitting completed state
        product.productStatus = status;
        productUpdateSubject.sink.add(ApiResponse.completed(product)); // Emit updated product
        // Optionally: Refresh the entire list if needed, or rely on UI updating the specific item
        // getProductList();
      } else {
         // API status failed, emit error state for this product
         productUpdateSubject.sink.add(ApiResponse.error(apiMsg, product));
         // openSimpleSnackbar(apiMsg); // Might be redundant
      }
    } catch (e) {
      if (!state.mounted) return;
      String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
      // Emit error state for this product
      productUpdateSubject.sink.add(ApiResponse.error(errorMessage, product));
      logd(tag, "Update Product Status Error: $e");
      openSimpleSnackbar(errorMessage); // Show error
    }
  }

  @override
  void dispose() {
    productListSubject.close();
    productUpdateSubject.close(); // Close the product update stream
    // No super.dispose needed
  }

  // Keep logd for specific bloc logging if needed
  // myLog(String message) {
  //   logd(tag, "$runtimeType ==> $message");
  // }
}
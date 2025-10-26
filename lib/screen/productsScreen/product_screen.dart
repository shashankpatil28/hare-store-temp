// Path: lib/screen/productsScreen/product_screen.dart

import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../commonView/custom_switch.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/no_record_found.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import 'product_bloc.dart';
import 'product_dl.dart';
import 'product_shimmer.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  ProductBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc = _bloc ?? ProductBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMainBackground,
      appBar: AppBar(
        title: Text(
          languages.navProducts,
          style: toolbarStyle(),
        ),
        leading: const BackButton(),
        elevation: 1,
      ),
      body: StreamBuilder<ApiResponse<ProductResponse>>(
        stream: _bloc!.productListSubject,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            switch (snapshot.data!.status) {
              case Status.loading:
                return const ProductShimmer();
              case Status.completed:
                ProductResponse? data = snapshot.data!.data;
                if (data != null && data.productList.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
                    itemCount: data.productList.length,
                    itemBuilder: (context, index) {
                      final category = data.productList[index];
                      return StickyHeader(
                        header: Container(
                          color: colorMainBackground,
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.025,
                              vertical: deviceHeight * 0.01),
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            category.categoryName,
                            style: bodyText(
                                fontSize: textSizeMediumBig,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        content: ListView.builder(
                          itemCount: category.products.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsetsDirectional.zero,
                          itemBuilder: (context, position) {
                            final product = category.products[position];

                            return StreamBuilder<ApiResponse<Products>>(
                              stream: _bloc!.productUpdateStream
                                  .where((event) => event.data?.productId == product.productId),
                              initialData: ApiResponse.completed(product),
                              builder: (context, productSnapshot) {
                                final updatedProduct = productSnapshot.data?.data ?? product;
                                final isLoadingUpdate = productSnapshot.data?.status == Status.loading;
                                final isErrorUpdate = productSnapshot.data?.status == Status.error;
                                final isEnabled = updatedProduct.productStatus == 1;

                                return Container(
                                  padding: EdgeInsetsDirectional.only(
                                      start: deviceWidth * 0.02,
                                      end: deviceWidth * 0.02),
                                  margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.005),
                                  color: colorWhite,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              top: deviceHeight * 0.012,
                                              bottom: deviceHeight * 0.012,
                                              end: deviceWidth * 0.02),
                                          child: Text(
                                            updatedProduct.productName,
                                            style: bodyText(),
                                          ),
                                        ),
                                      ),
                                      if (isLoadingUpdate)
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
                                          child: SizedBox(
                                            width: deviceAverageSize * 0.03,
                                            height: deviceAverageSize * 0.03,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: colorPrimary,
                                            ),
                                          ),
                                        )
                                      else if (isErrorUpdate)
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
                                          child: Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                            size: deviceAverageSize * 0.03,
                                          ),
                                        )
                                      else
                                        CustomSwitch(
                                          width: deviceWidth * 0.1,
                                          radius: deviceAverageSize * 0.03,
                                          activeColor: colorAccept,
                                          disableColor: offColor,
                                          thumbColor: colorWhite,
                                          innerPadding: EdgeInsets.all(deviceAverageSize * 0.005),
                                          thumbSize: deviceAverageSize * 0.022,
                                          value: isEnabled,
                                          onChanged: (value) {
                                            _bloc?.updateProductStatus(updatedProduct, value ? 1 : 0);
                                          },
                                        ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  // Show NoRecordFound if list is empty or data is null
                  return NoRecordFound(
                    message: snapshot.data?.message ?? languages.emptyData,
                  );
                }
              case Status.error:
                 // The Retry widget should just show the icon to trigger the retry action.
                 // Error messages are typically displayed separately or by the Error widget.
                return Center(
                  child: Retry(
                    // MODIFIED: Removed the 'message' parameter
                    onRetryPressed: () => _bloc?.getProductList(),
                  ),
                );
            }
          }
          // Default case: show shimmer while waiting for initial data
          return const ProductShimmer();
        },
      ),
    );
  }
}
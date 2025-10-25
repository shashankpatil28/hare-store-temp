// Path: lib/screen/orderDetailScreen/item_deliveries_order_detail_product.dart

import 'package:flutter/material.dart';

import '../../commonView/widget_util.dart';
import '../../utils/common_util.dart';
import 'order_detail_dl.dart';

class ItemDeliveriesOrderDetailProduct extends StatelessWidget {
  final ItemList productListItem;

  const ItemDeliveriesOrderDetailProduct(
      {super.key, required this.productListItem});

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${productListItem.productName}${productListItem.EAN != "" ? " (${productListItem.EAN})" : ""}",
                    textAlign: TextAlign.start,
                    style: bodyText(
                        textColor: colorBlack, fontWeight: FontWeight.w600),
                  ),
                  // if ((productListItem.addOns).trim().isNotEmpty)
                  //   Text(
                  //     productListItem.addOns,
                  //     textAlign: TextAlign.start,
                  //     style: bodyText(fontSize: textSizeSmall, textColor: colorTextCommonLight),
                  //   ),
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: deviceWidth * 0.02),
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.016),
                        decoration: getBoxDecoration(
                            color: colorPrimary.withOpacity(0.15),
                            radius: deviceAverageSize * 0.006,
                            border: Border.all(color: colorPrimaryDark)),
                        child: Text(
                          "${productListItem.quantity}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: deviceAverageSize * textSizeSmall,
                              color: colorTextCommonLight,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.03),
                      Text(
                        "X",
                        style: bodyText(),
                      ),
                      SizedBox(width: deviceWidth * 0.03),
                      Text(
                        getAmountWithCurrency(
                            getDouble(productListItem.productPrice)),
                        style: bodyText(),
                      )
                    ],
                  ),
                  if (productListItem.options.isNotEmpty)
                    SizedBox(
                      width: deviceWidth * 0.95,
                      child: Column(
                        children: [
                          Text("AddOn Option : ",
                              textAlign: TextAlign.start,
                              style: bodyText(
                                  textColor: colorBlack,
                                  fontWeight: FontWeight.w300)),
                          Container(
                              height: deviceHeight * 0.2,
                              margin: EdgeInsets.symmetric(
                                  vertical: deviceHeight * 0.02),
                              padding: EdgeInsets.symmetric(
                                  horizontal: deviceWidth * 0.016),
                              child: ListView.builder(
                                  itemCount: productListItem.options.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            productListItem
                                                .options[index].optionName,
                                            style: bodyText(
                                                textColor: colorBlack,
                                                fontWeight: FontWeight.w300)),
                                        Text(
                                            productListItem
                                                .options[index].optionAmount
                                                .toString(),
                                            style: bodyText(
                                                textColor: colorBlack,
                                                fontWeight: FontWeight.w300))
                                      ],
                                    );
                                  }))
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: deviceWidth * 0.012),
                // padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.016),
                child: Text(
                  getAmountWithCurrency(getDouble(productListItem.priceForOne)),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: deviceAverageSize * textSizeSmall,
                    color: colorTextCommon,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

// Path: lib/screen/ordersHistoryScreen/bottom_sheet_filter.dart

import 'package:flutter/material.dart';

import '../../commonView/my_widgets.dart';
import '../../utils/common_util.dart';
import 'order_history_bloc.dart';

class OrderHistoryFilterBs extends StatefulWidget {
  final Function(HistoryFilterModel) onSelected;
  final HistoryFilterModel? defaultSelected;
  final List<HistoryFilterModel> filterList;

  const OrderHistoryFilterBs({super.key, this.defaultSelected, required this.onSelected, required this.filterList});

  @override
  OrderHistoryFilterBsState createState() => OrderHistoryFilterBsState();
}

class OrderHistoryFilterBsState extends State<OrderHistoryFilterBs> {
  HistoryFilterModel? selectedValue;

  @override
  void initState() {
    selectedValue = widget.defaultSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.02, top: deviceHeight * 0.01, bottom: deviceHeight * 0.015, end: deviceWidth * 0.02),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(deviceAverageSize * 0.05),
            topStart: Radius.circular(deviceAverageSize * 0.05),
          ),
          color: colorMainBackground),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: deviceWidth * 0.12,
            margin: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.01),
            child: Divider(
              color: colorDivider,
              thickness: deviceHeight * 0.0035,
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.025, end: deviceWidth * 0.015),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    languages.filterOrder,
                    textAlign: TextAlign.start,
                    style: bodyText(textColor: colorTextCommon, fontSize: textSizeLarge, fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorPrimary,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(deviceAverageSize * 0.003),
                        child: Icon(
                          Icons.close_rounded,
                          size: deviceAverageSize * 0.032,
                          color: colorWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: deviceHeight * 0.01),
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: deviceAverageSize * 0.0005,
                );
              },
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedValue = widget.filterList[index];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.002),
                    child: Row(
                      children: [
                        Radio(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          groupValue: selectedValue,
                          value: widget.filterList[index],
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.015),
                          child: Text(
                            widget.filterList[index].filterName,
                            textAlign: TextAlign.start,
                            style: bodyText(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: widget.filterList.length,
            ),
          ),
          CustomRoundedButton(
            context,
            languages.update,
            () {
              if (selectedValue != null) {
                Navigator.pop(context, true);
                widget.onSelected(selectedValue!);
              }
            },
            textSize: textSizeLargest,
            minWidth: 0.9,
            minHeight: 0.06,
            fontWeight: FontWeight.bold,
            margin: EdgeInsetsDirectional.only(
              top: deviceHeight * 0.01,
            ),
          )
        ],
      ),
    );
  }
}

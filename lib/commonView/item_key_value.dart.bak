// Path: lib/commonView/item_key_value.dart

import 'package:flutter/material.dart';

import '../network/base_dl.dart';
import '../utils/common_util.dart';

class ItemKeyValue extends StatelessWidget {
  final KeyValueModel keyValueModel;

  const ItemKeyValue({super.key, required this.keyValueModel});

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.005, top: deviceHeight * 0.003),
        child: Column(
          children: [
            (keyValueModel.setDivider ?? false)
                ? Divider(
                    color: colorMainBackground,
                    height: deviceHeight * 0.01,
                    thickness: deviceAverageSize * 0.003,
                  )
                : Container(),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    keyValueModel.key,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: bodyText(
                        fontSize: (keyValueModel.setBold ?? false) ? textSizeBig : textSizeRegular,
                        textColor: /*keyValueModel.setBold ? colorBlack : */ colorBlack,
                        fontWeight: (keyValueModel.setBold ?? false) ? FontWeight.w600 : FontWeight.normal),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Text(
                    keyValueModel.value,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: bodyText(
                        fontSize: (keyValueModel.setBold ?? false) ? textSizeBig : textSizeRegular,
                        textColor: colorBlack,
                        fontWeight: (keyValueModel.setBold ?? false) ? FontWeight.w600 : FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

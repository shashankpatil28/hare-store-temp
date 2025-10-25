// Path: lib/screen/manageCard/manage_card.dart

import 'package:flutter/material.dart';

import '../../../commonView/no_record_found.dart';
import '../../commonView/my_widgets.dart';
import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/common_util.dart';
import 'item_manage_card.dart';
import 'manage_card_bloc.dart';
import 'manage_card_dl.dart';
import 'manage_card_shimmer.dart';

class ManageCard extends StatefulWidget {
  const ManageCard({super.key});

  @override
  State<StatefulWidget> createState() => _ManageCardState();
}

class _ManageCardState extends State<ManageCard> {
  late ManageCardBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = ManageCardBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          languages.manageCard,
          style: toolbarStyle(),
        ),
      ),
      body: _buildManageCard(context),
    );
  }

  _buildManageCard(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.04, top: deviceHeight * 0.025, bottom: deviceHeight * 0.01, end: deviceWidth * 0.04),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languages.safeAndSecurePaymentMethod,
                    maxLines: 1,
                    style: bodyText(fontWeight: FontWeight.w600, fontSize: textSizeBig),
                  ),
                  SizedBox(height: deviceHeight * 0.015),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.01)),
                          child: Image.asset(
                            "assets/images/payment_visa.png",
                            width: deviceWidth * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.04),
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.01)),
                          child: Image.asset(
                            "assets/images/payment_master_card.png",
                            width: deviceWidth * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.04),
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.01)),
                          child: Image.asset(
                            "assets/images/payment_amex.png",
                            width: deviceWidth * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.04),
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.01)),
                          child: Image.asset(
                            "assets/images/payment_discover_network.png",
                            width: deviceWidth * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: deviceHeight * 0.045),
                  Text(
                    languages.selectCreditDebitCard,
                    maxLines: 1,
                    style: bodyText(fontWeight: FontWeight.w600, fontSize: textSizeBig),
                  ),
                ],
              ),
            ),
            Expanded(child: cardList()),
          ],
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: CustomRoundedButton(
            context,
            languages.addCreditDebitCard,
            () {
              _bloc.openAddCard();
            },
            fontWeight: FontWeight.w700,
            textSize: textSizeLarge,
            minWidth: deviceWidth,
            bgColor: colorPrimary,
            textColor: colorWhite,
            minHeight: commonBtnHeight,
            padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.18, end: deviceWidth * 0.18),
            margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.05, end: deviceWidth * 0.05, top: deviceHeight * 0.05, bottom: deviceHeight * 0.035),
          ),
        ),
      ],
    );
  }

  cardList() {
    return StreamBuilder<ApiResponse<CardModel>>(
      stream: _bloc.subject,
      builder: (context, snap) {
        var isLoading = snap.hasData && snap.data?.status == Status.loading;
        var isError = snap.hasData && snap.data?.status == Status.error;
        Widget simmerView = Container(
          margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.005),
          child: ManageCardShimmer(
            enabled: isLoading,
          ),
        );
        List<CardListItem> cardList = snap.data?.data?.cardList ?? [];
        return isLoading
            ? simmerView
            : (!isError && cardList.isNotEmpty)
                ? ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsetsDirectional.only(top: 0, bottom: deviceHeight * 0.12),
                    itemCount: cardList.length,
                    itemBuilder: (BuildContext context, position) {
                      return Container(
                        padding: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.007),
                        color: colorMainLightGray.withOpacity(0.2),
                        child: ItemManageCard(
                          cardListItem: cardList[position],
                          onClickRemove: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return StreamBuilder<ApiResponse<BaseModel>>(
                                  stream: _bloc.subjectDeleteCard,
                                  builder: (context, snapLoading) {
                                    var isLoading = snapLoading.hasData && snapLoading.data?.status == Status.loading;
                                    return SimpleDialogUtil(
                                      isLoading: isLoading,
                                      title: languages.remove,
                                      message: languages.sureToRemove,
                                      positiveButtonTxt: languages.remove,
                                      negativeButtonTxt: languages.cancel,
                                      onPositivePress: () {
                                        _bloc.deleteCard(cardList[position].cardId);
                                      },
                                      onNegativePress: () {
                                        Navigator.pop(context, true);
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  )
                : NoRecordFound(message: snap.data?.message ?? "");
      },
    );
  }
}

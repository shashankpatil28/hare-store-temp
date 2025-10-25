// Path: lib/screen/wallet/walletTransaction/wallet_transaction.dart

import 'package:flutter/material.dart';

import '../../../../commonView/no_record_found.dart';
import '../../../commonView/my_widgets.dart';
import '../../../network/api_response.dart';
import '../../../utils/common_util.dart';
import '../../homeScreen/home_screen.dart';
import '../wallet_dl.dart';
import 'item_wallet_transaction.dart';
import 'wallet_transaction_bloc.dart';
import 'wallet_transaction_shimmer.dart';

class WalletTransaction extends StatefulWidget {
  final double? walletAmount;
  final bool fromNotification;

  const WalletTransaction({super.key, this.walletAmount, this.fromNotification = false});

  @override
  State<StatefulWidget> createState() => _WalletTransactionState();
}

class _WalletTransactionState extends State<WalletTransaction> {
  late WalletTransactionBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = WalletTransactionBloc(context, widget.walletAmount, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () {
          if (!Navigator.canPop(context)) {
            openScreenWithClearPrevious(context, const HomeScreen());
          }
          return Future.value(true);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: const BackButton(),
            centerTitle: false,
            titleSpacing: 0,
            title: Text(
              languages.transaction,
              style: toolbarStyle(),
            ),
          ),
          body: _buildWalletTransaction(context),
        ),
      );

  _buildWalletTransaction(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: colorPrimary,
              image: DecorationImage(image: AssetImage("assets/images/main_img_abstract_bg.png"), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.02),
                  child: Text(
                    languages.currentBalance,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: bodyText(fontSize: textSizeSmallest, textColor: colorWhite, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01, bottom: deviceHeight * 0.02),
                  child: StreamBuilder<double>(
                      stream: _bloc.walletAmountStream,
                      builder: (context, snap) {
                        return StreamBuilder<ApiResponse<WalletBalancePojo>>(
                            stream: _bloc.subjectGetBalance,
                            builder: (context, snapLoading) {
                              var isLoading = snapLoading.hasData && snapLoading.data?.status == Status.loading;
                              return isLoading
                                  ? Container(
                                      margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.008),
                                      child: Loading(
                                        strokeWidth: deviceHeight * cpiStrokeWidthSmall,
                                        size: deviceHeight * cpiSizeRegular,
                                        color: colorWhite,
                                      ),
                                    )
                                  : Text(
                                      getAmountWithCurrency(snap.data ?? 0),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: bodyText(fontSize: 0.04, textColor: colorWhite, fontWeight: FontWeight.bold),
                                    );
                            });
                      }),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: transactionList(),
          flex: 4,
        ),
      ],
    );
  }

  transactionList() => StreamBuilder<ApiResponse<WalletTransactionPojo>>(
        stream: _bloc.subject,
        builder: (context, snap) {
          var isLoading = snap.hasData && snap.data?.status == Status.loading;
          var isError = snap.hasData && snap.data?.status == Status.error;

          WalletTransactionShimmer simmerView = WalletTransactionShimmer(
            enabled: isLoading,
          );
          List<TransactionsItem> transactionList = snap.data?.data?.transactions ?? [];
          return isLoading
              ? Container(margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.008), child: simmerView)
              : (!isError && transactionList.isNotEmpty)
                  ? ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsetsDirectional.only(top: 0, bottom: deviceHeight * 0.02),
                      itemCount: transactionList.length,
                      itemBuilder: (BuildContext context, position) {
                        return ItemWalletTransaction(
                          transactionsItem: transactionList[position],
                        );
                      },
                    )
                  : NoRecordFound(
                      message: snap.data?.message ?? "",
                    );
        },
      );
}

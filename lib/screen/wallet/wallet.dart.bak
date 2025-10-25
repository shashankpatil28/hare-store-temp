// Path: lib/screen/wallet/wallet.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/custom_text_field.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import 'wallet_bloc.dart';
import 'wallet_dl.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  WalletState createState() => WalletState();
}

class WalletState extends State<Wallet> with WidgetsBindingObserver {
  late WalletBloc _bloc;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bloc = WalletBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _bloc.getWalletAmount();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    WidgetsBinding.instance.removeObserver(this);
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
          languages.wallet,
          style: toolbarStyle(),
        ),
      ),
      body: _buildWallet(context),
    );
  }

  _buildWallet(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: colorPrimary,
              image: DecorationImage(image: AssetImage("assets/images/main_img_abstract_bg.png"), fit: BoxFit.cover),
            ),
            padding: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
            child: Column(
              children: [
                Text(
                  languages.currentBalance,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: bodyText(fontSize: textSizeSmall, textColor: colorWhite, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.005, bottom: deviceHeight * 0.01),
                  child: walletAmount(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: CustomRoundedButton(
                          context,
                          languages.viewTransaction,
                          () {
                            _bloc.openWalletTransactionScreen();
                          },
                          fontWeight: FontWeight.w600,
                          textSize: textSizeSmall,
                          minWidth: commonBtnWidth,
                          setBorder: true,
                          textColor: colorWhite,
                          bgColor: colorWhite,
                          minHeight: commonBtnHeightMedium,
                          margin: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.025),
                        ),
                      ),
                      if (showWalletTransferModule) SizedBox(width: deviceWidth * 0.03),
                      if (showWalletTransferModule)
                        Flexible(
                          flex: 1,
                          child: CustomRoundedButton(
                            context,
                            languages.transfer,
                            () {
                              _bloc.openWalletTransfer();
                            },
                            fontWeight: FontWeight.w600,
                            textSize: textSizeSmall,
                            minWidth: commonBtnWidth,
                            setBorder: true,
                            textColor: colorWhite,
                            bgColor: colorWhite,
                            minHeight: commonBtnHeightMedium,
                            margin: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.025),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.03, start: deviceWidth * 0.06),
                child: Text(
                  languages.addMoney,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.002, start: deviceWidth * 0.06),
                child: Text(
                  languages.walletMsg,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: bodyText(textColor: colorTextLight, fontSize: textSizeSmall, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.025),
                padding: EdgeInsetsDirectional.only(
                  start: deviceWidth * 0.06,
                  top: deviceHeight * 0.01,
                  end: deviceWidth * 0.06,
                  bottom: deviceHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(deviceAverageSize * 0.02)),
                  color: colorPrimary.withOpacity(0.06),
                ),
                child: Form(
                  key: _bloc.formKey,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(top: deviceHeight * 0.025),
                    child: TextFormFieldCustom(
                      controller: _bloc.addAmountTEC,
                      backgroundColor: Colors.transparent,
                      onChanged: (value) {
                        _bloc.setError = true;
                      },
                      decoration: InputDecoration(labelText: languages.enterAmount),
                      useLabelWithBorder: true,
                      textInputAction: TextInputAction.done,
                      style: bodyText(textColor: colorTextCommon, fontWeight: FontWeight.w600),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('^[1-9][0-9]{0,}(\\.[0-9]{0,})?\$')),
                      ],
                      setError: true,
                      validator: (value) {
                        if (_bloc.setError) {
                          return validateEmptyField(value, languages.pleaseEnterAmount);
                        }
                        return "";
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            alignment: AlignmentDirectional.bottomCenter,
            child: addButton(),
          ),
        ),
      ],
    );
  }

  walletAmount() => StreamBuilder<double>(
        stream: _bloc.walletAmount,
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
                      snap.data != null ? getAmountWithCurrency(snap.data) : "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: bodyText(fontSize: 0.045, textColor: colorWhite, fontWeight: FontWeight.bold),
                    );
            },
          );
        },
      );

  addButton() => StreamBuilder<ApiResponse<WalletBalancePojo>>(
        stream: _bloc.subjectAddAmount,
        builder: (context, snapLoading) {
          var isLoading = snapLoading.hasData && snapLoading.data?.status == Status.loading;
          return CustomRoundedButton(
            context,
            languages.addMoney,
            () {
              if (_bloc.formKey.currentState?.validate() ?? false) {
                _bloc.openSelectPaymentScreen();
              }
            },
            icon: Icon(
              Icons.add_circle_outline_sharp,
              color: colorWhite,
              size: deviceAverageSize * 0.04,
            ),
            setProgress: isLoading,
            fontWeight: FontWeight.w600,
            textSize: textSizeBig,
            minWidth: commonBtnWidth,
            bgColor: colorPrimary,
            textColor: colorWhite,
            minHeight: commonBtnHeightMedium,
            padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.05, end: deviceWidth * 0.05),
            margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.05, bottom: deviceHeight * 0.02),
          );
        },
      );
}

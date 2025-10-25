// Path: lib/screen/walletTransfer/wallet_transfer.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/custom_text_field.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/common_util.dart';
import 'search_user.dart';
import 'wallet_transfer_bloc.dart';

class WalletTransfer extends StatefulWidget {
  final double walletAmount;

  const WalletTransfer({Key? key, this.walletAmount = 0}) : super(key: key);

  @override
  State<WalletTransfer> createState() => _WalletTransferState();
}

class _WalletTransferState extends State<WalletTransfer> {
  late WalletTransferBloc _bloc;

  @override
  void initState() {
    _bloc = WalletTransferBloc(context, widget.walletAmount, this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _bloc.walletAmount);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          automaticallyImplyLeading: true,
          title: Text(
            languages.transfer,
            style: toolbarStyle(),
          ),
        ),
        body: Form(
          key: _bloc.formKey,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  _bloc.textEditingController.text = "";
                  _bloc.searchUser.add(null);
                  openScreenWithResult(
                      context,
                      SearchUser(
                        bloc: _bloc,
                      )).then((value) {
                    // TransferUserList transferUserList = value as TransferUserList;
                    // print(value);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.02)),
                    border: Border.all(color: colorMainView, width: deviceAverageSize * 0.002),
                    color: colorWhite,
                  ),
                  margin: EdgeInsetsDirectional.only(
                    start: deviceWidth * 0.03,
                    end: deviceWidth * 0.03,
                    bottom: deviceHeight * 0.025,
                    top: deviceHeight * 0.02,
                  ),
                  padding: EdgeInsets.all(deviceAverageSize * 0.015),
                  child: Row(
                    children: [
                      const Icon(Icons.search_sharp, color: colorLoginTextLight),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.05),
                          child: Hero(tag: "search", child: Text(languages.searchByContactOrEmail, style: bodyText(textColor: colorMainLightGray))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.015, horizontal: deviceWidth * 0.02),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StreamBuilder<ApiResponse<BaseModel>>(
                            stream: _bloc.transferToWallet,
                            builder: (context, snapshot) {
                              return Padding(
                                padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.01),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(style: bodyText(fontSize: textSizeBig, fontWeight: FontWeight.w600), children: [
                                    TextSpan(
                                      text: "${languages.youHave} ",
                                    ),
                                    TextSpan(
                                      text: getAmountWithCurrency(_bloc.walletAmount),
                                      style: bodyText(fontSize: textSizeBig, fontWeight: FontWeight.bold, textColor: colorPrimary),
                                    ),
                                    TextSpan(
                                      text: " ${languages.amountToTransfer}",
                                    )
                                  ]),
                                ),
                              );
                            }),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02, vertical: deviceHeight * 0.01),
                          margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.015),
                          alignment: Alignment.center,
                          child: TextFormFieldCustom(
                            setError: true,
                            // enable: false,
                            decoration: InputDecoration(labelText: languages.beneficial),
                            useLabelWithBorder: true,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            style: bodyText(fontSize: textSizeMediumBig, textColor: colorTextCommon, fontWeight: FontWeight.w600),
                            backgroundColor: colorGray.withOpacity(0.5),
                            controller: _bloc.textBeneficialController,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02, vertical: deviceHeight * 0.01),
                          margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
                          alignment: Alignment.center,
                          child: TextFormFieldCustom(
                            setError: true,
                            // enable: false,
                            useLabelWithBorder: true,
                            decoration: InputDecoration(labelText: languages.beneficialContactNumber),
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            style: bodyText(fontSize: textSizeMediumBig, textColor: colorTextCommon, fontWeight: FontWeight.w600),
                            backgroundColor: colorGray.withOpacity(0.5),
                            controller: _bloc.textNumberController,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02, vertical: deviceHeight * 0.01),
                          margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
                          alignment: Alignment.center,
                          child: TextFormFieldCustom(
                            setError: true,
                            // enable: false,
                            useLabelWithBorder: true,
                            decoration: InputDecoration(labelText: languages.beneficialEmail),
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            style: bodyText(fontSize: textSizeMediumBig, textColor: colorTextCommon, fontWeight: FontWeight.w600),
                            backgroundColor: colorGray.withOpacity(0.5),
                            controller: _bloc.textEmailController,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02, vertical: deviceHeight * 0.01),
                          margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
                          alignment: Alignment.center,
                          child: TextFormFieldCustom(
                            setError: true,
                            textAlign: TextAlign.start,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              TextInputFormatter.withFunction((oldValue, newValue) {
                                var hasMatch = getTwoDigitRegExp(newValue.text);
                                if (hasMatch || newValue.text.isEmpty) {
                                  return newValue;
                                }
                                return oldValue;
                              }),
                            ],
                            useLabelWithBorder: true,
                            decoration: InputDecoration(labelText: languages.amountToTransfer),
                            textInputAction: TextInputAction.done,
                            prefix: Container(
                              padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.02),
                              child: Text(
                                "${prefGetString(prefSelectedCurrency)} ",
                                textAlign: TextAlign.start,
                                style: bodyText(fontSize: textSizeMediumBig, textColor: colorPrimary),
                              ),
                            ),
                            suffix: Padding(
                              padding: EdgeInsetsDirectional.only(end: deviceWidth * 0.02),
                            ),
                            style: bodyText(fontSize: textSizeMediumBig, textColor: colorTextCommon, fontWeight: FontWeight.w600),
                            controller: _bloc.textAmountController,
                            validator: (value) {
                              String val = validateEmptyField(value, languages.enterAmount);
                              if (val.isEmpty) {
                                double amount = getDoubleFromDynamic(value);
                                if (amount > _bloc.walletAmount) {
                                  val = "${languages.youCantTransfer} ${_bloc.walletAmount}";
                                } else if (amount <= 0) {
                                  val = languages.invalidAmountMsg;
                                }
                              }

                              return val;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: StreamBuilder<ApiResponse<BaseModel>>(
                    stream: _bloc.transferToWallet,
                    builder: (context, snapLoading) {
                      var isLoading = snapLoading.hasData && snapLoading.data?.status == Status.loading;
                      return CustomRoundedButton(
                        context,
                        languages.transfer,
                        isLoading
                            ? null
                            : () {
                                if (_bloc.formKey.currentState!.validate()) {
                                  if (_bloc.transferUserList != null) {
                                    _bloc.transferToUser();
                                  } else {
                                    openSimpleSnackbar(languages.selectUser);
                                  }
                                }
                              },
                        fontWeight: FontWeight.bold,
                        textColor: colorWhite,
                        textSize: textSizeLarge,
                        textAlign: TextAlign.center,
                        setBorder: false,
                        bgColor: colorPrimary,
                        maxLine: 1,
                        minWidth: double.infinity,
                        minHeight: commonBtnHeight,
                        setProgress: isLoading,
                        progressColor: colorWhite,
                        progressSize: cpiSizeSmall,
                        progressStrokeWidth: cpiStrokeWidthSmall,
                        padding: EdgeInsetsDirectional.all(deviceAverageSize * 0.01),
                        margin: EdgeInsetsDirectional.only(
                          start: deviceWidth * 0.035,
                          end: deviceWidth * 0.035,
                          bottom: deviceHeight * 0.03,
                          top: deviceHeight * 0.02,
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

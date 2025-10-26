// Path: lib/screen/bankDetailScreen/bank_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/custom_text_field.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import 'bank_detail_bloc.dart';
import 'bank_detail_shimmer.dart';

class BankDetailScreen extends StatefulWidget {
  const BankDetailScreen({super.key});

  @override
  State createState() => _BankDetailScreenState();
}

class _BankDetailScreenState extends State<BankDetailScreen> {
  BankDetailBloc? _bloc;
  var hintStyle = bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600, textColor: colorMainLightGray);
  var textStyle = bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600);
  double centerSpace = deviceHeight * 0.025;

  @override
  void didChangeDependencies() {
    _bloc = _bloc ?? BankDetailBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MODIFIED: Removed local formKey. The BLoC's key will be used.

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        titleTextStyle: toolbarStyle(),
        title: Text(languages.bankDetail),
      ),
      body: StreamBuilder<ApiResponse>(
          // MODIFIED: Used 'bankDetailStream' getter
          stream: _bloc!.bankDetailStream,
          builder: (context, snapshot) {
            var isLoading = (snapshot.data?.status ?? Status.completed) == Status.loading;
            if (isLoading) {
              return const BankDetailShimmer();
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    // MODIFIED: Used the BLoC's formKey
                    key: _bloc!.formKey,
                    child: Container(
                      margin: EdgeInsets.all(deviceAverageSize * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: centerSpace / 2),
                          TextFormFieldCustom(
                            keyboardType: TextInputType.number,
                            style: textStyle,
                            controller: _bloc!.accountNumber,
                            setError: true,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            useLabelWithBorder: true,
                            decoration: InputDecoration(labelText: languages.accNo),
                            validator: (value) {
                              return validateEmptyField(value, languages.enterAccountNum);
                            },
                          ),
                          SizedBox(height: centerSpace),
                          TextFormFieldCustom(
                            keyboardType: TextInputType.name,
                            style: textStyle,
                            controller: _bloc!.accountHolderName,
                            setError: true,
                            useLabelWithBorder: true,
                            decoration: InputDecoration(labelText: languages.accHolderName),
                            validator: (value) {
                              return validateEmptyField(value, languages.enterAccountHolderName);
                            },
                          ),
                          SizedBox(height: centerSpace),
                          TextFormFieldCustom(
                            keyboardType: TextInputType.name,
                            style: textStyle,
                            controller: _bloc!.bankName,
                            setError: true,
                            useLabelWithBorder: true,
                            decoration: InputDecoration(labelText: languages.bankName),
                            validator: (value) {
                              return validateEmptyField(value, languages.enterBankName);
                            },
                          ),
                          SizedBox(height: centerSpace),
                          TextFormFieldCustom(
                            keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: _bloc!.bankLocation,
                            setError: true,
                            useLabelWithBorder: true,
                            decoration: InputDecoration(labelText: languages.bankLocation),
                            validator: (value) {
                              return validateEmptyField(value, languages.enterBankLocation);
                            },
                          ),
                          SizedBox(height: centerSpace),
                          TextFormFieldCustom(
                            keyboardType: TextInputType.emailAddress,
                            style: textStyle,
                            controller: _bloc!.paymentEmail,
                            setError: true,
                            useLabelWithBorder: true,
                            decoration: InputDecoration(labelText: languages.paymentEmail),
                            validator: (value) {
                              return emailValidate(value);
                            },
                          ),
                          SizedBox(height: centerSpace),
                          TextFormFieldCustom(
                            keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: _bloc!.swiftCode,
                            setError: true,
                            textInputAction: TextInputAction.done,
                            useLabelWithBorder: true,
                            decoration: InputDecoration(labelText: languages.bankCode),
                            validator: (value) {
                              return validateEmptyField(value, languages.enterSwiftCode);
                            },
                          ),
                          SizedBox(height: centerSpace),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: StreamBuilder<ApiResponse>(
                      // MODIFIED: Used 'updateStream' getter
                      stream: _bloc!.updateStream,
                      builder: (context, snapshot) {
                        return CustomRoundedButton(
                          context,
                          languages.submit,
                          () {
                            // MODIFIED: Validated using the BLoC's formKey
                            if (_bloc!.formKey.currentState!.validate()) {
                              _bloc?.callUpdateBankDetailApi();
                            }
                          },
                          textColor: colorWhite,
                          setBorder: false,
                          fontWeight: FontWeight.w700,
                          minHeight: commonBtnHeight,
                          textSize: textSizeLarge,
                          textAlign: TextAlign.center,
                          bgColor: colorPrimary,
                          maxLine: 1,
                          minWidth: double.infinity,
                          elevation: deviceAverageSize * 0.005,
                          margin: EdgeInsetsDirectional.only(
                            start: deviceWidth * 0.035,
                            end: deviceWidth * 0.035,
                            bottom: deviceHeight * 0.03,
                            top: deviceHeight * 0.02,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
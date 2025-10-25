// Path: lib/dialog/forgotPasswordDialog/forgot_password_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/customCountryCodePicker/custom_country_code_picker.dart';
import '../../commonView/custom_text_field.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import 'forgot_pass_req_pojo.dart';
import 'forgot_password_bloc.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  ForgotPasswordDialogState createState() => ForgotPasswordDialogState();
}

class ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  late ForgotPassBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = ForgotPassBloc(context, this);
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
      backgroundColor: Colors.transparent,
      body: Builder(builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(deviceAverageSize * dialougePadding),
          backgroundColor: colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(deviceAverageSize * 0.02),
          ),
          child: Container(
            padding: EdgeInsets.all(deviceAverageSize * 0.025),
            child: Form(
              key: _bloc.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: deviceAverageSize * 0.02),
                    child: Text(
                      "${languages.forgotPassword}?",
                      style: bodyText(
                        textColor: colorTextCommon,
                        fontSize: textSizeLargest,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    languages.contactNumber,
                    style: bodyText(
                      textColor: colorTextCommon,
                      fontSize: textSizeRegular,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: deviceWidth * 0.02,
                      end: deviceWidth * 0.02,
                      top: deviceHeight * 0.025,
                      bottom: deviceHeight * 0.0,
                    ),
                    child: TextFormFieldCustom(
                      backgroundColor: colorMainBackground,
                      textInputAction: TextInputAction.done,
                      controller: _bloc.mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: "${languages.enterContactNumber}*"),
                      prefix: CustomCountryCodePicker(
                        showDropDownButton: true,
                        flagWidth: deviceHeight * 0.035,
                        showFlag: true,
                        showFlagDialog: true,
                        padding: const EdgeInsets.all(0),
                        dialogSize: Size(deviceWidth * 0.9, deviceHeight * 0.75),
                        textStyle: bodyText(fontSize: textSizeSmall, textColor: colorTextCommon),
                        dialogTextStyle: bodyText(fontSize: textSizeSmall, textColor: colorTextCommon),
                        onChanged: (value) {
                          _bloc.changeCountry(value);
                        },
                        onInit: (countryCode) {
                          _bloc.changeCountry(countryCode ?? defaultCountryCode);
                        },
                        initialSelection: defaultCountryCode.name,
                      ),
                      useLabelWithBorder: true,
                      setError: true,
                      style: bodyText(fontSize: textSizeRegular, textColor: colorBlack),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        return validateEmptyField(value, languages.enterContactNumber);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomRoundedButton(
                        context,
                        languages.cancel,
                        () {
                          Navigator.pop(context, true);
                        },
                        minWidth: 0.15,
                        minHeight: 0.04,
                        textAlign: TextAlign.center,
                        textSize: textSizeSmall,
                        textColor: colorPrimary,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                        setBorder: true,
                        borderWidth: 0.003,
                        padding: EdgeInsetsDirectional.only(
                          start: deviceAverageSize * 0.03,
                          end: deviceAverageSize * 0.03,
                          top: deviceAverageSize * 0.005,
                          bottom: deviceAverageSize * 0.005,
                        ),
                        margin: EdgeInsetsDirectional.only(
                          start: deviceWidth * 0.01,
                          end: deviceWidth * 0.03,
                          top: deviceHeight * 0.025,
                          bottom: deviceHeight * 0.01,
                        ),
                      ),
                      StreamBuilder<ApiResponse<ForgotPassReqPojo>>(
                          stream: _bloc.subject,
                          builder: (context, snapLoading) {
                            var isLoading = snapLoading.hasData && snapLoading.data!.status == Status.loading;

                            return CustomRoundedButton(
                              context,
                              languages.submit,
                              () {
                                if (_bloc.formKey.currentState!.validate()) {
                                  _bloc.forgotPass();
                                }
                              },
                              setProgress: isLoading,
                              progressSize: cpiSizeSmallest,
                              fontWeight: FontWeight.w700,
                              textSize: textSizeSmall,
                              minWidth: 0.2,
                              minHeight: 0.04,
                              bgColor: colorPrimary,
                              textColor: colorWhite,
                              padding: EdgeInsetsDirectional.only(
                                start: deviceAverageSize * 0.03,
                                end: deviceAverageSize * 0.03,
                                top: deviceAverageSize * 0.005,
                                bottom: deviceAverageSize * 0.005,
                              ),
                              margin: EdgeInsetsDirectional.only(
                                end: deviceWidth * 0.03,
                                top: deviceHeight * 0.025,
                                bottom: deviceHeight * 0.01,
                              ),
                            );
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

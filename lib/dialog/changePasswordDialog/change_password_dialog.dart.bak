// Path: lib/dialog/changePasswordDialog/change_password_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/custom_text_field.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../screen/loginScreen/login_dl.dart';
import '../../utils/common_util.dart';
import 'change_password_dialog_bloc.dart';

class ChangePasswordDialog extends StatefulWidget {
  final int storeId;

  const ChangePasswordDialog({super.key, this.storeId = 0});

  @override
  ChangePasswordDialogState createState() => ChangePasswordDialogState();
}

class ChangePasswordDialogState extends State<ChangePasswordDialog> {
  late ChangePasswordDialogBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = ChangePasswordDialogBloc(context, this);
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
      body: Dialog(
        insetPadding: dialogPending,
        shape: RoundedRectangleBorder(borderRadius: dialogBorderRadius),
        backgroundColor: colorWhite,
        child: Form(
          key: _bloc.formKey,
          child: Container(
            width: double.infinity,
            margin: EdgeInsetsDirectional.only(
                top: deviceHeight * 0.015, start: deviceWidth * 0.03, end: deviceWidth * 0.03, bottom: deviceHeight * 0.005),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  languages.setNewPassword,
                  textAlign: TextAlign.start,
                  style: bodyText(fontSize: textSizeLarge, fontWeight: FontWeight.w700, textColor: colorBlack),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.005, top: deviceHeight * 0.018),
                  child: Text(
                    languages.changePasswordMsg,
                    textAlign: TextAlign.start,
                    style: bodyText(fontSize: textSizeSmallest, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  height: deviceHeight * 0.065,
                  alignment: AlignmentDirectional.center,
                  // color: colorMainBackground,
                  margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.025, end: deviceWidth * 0.02, start: deviceWidth * 0.02),
                  child: TextFormFieldCustom(
                    controller: _bloc.otpController,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    useLabelWithBorder: true,
                    decoration: InputDecoration(labelText: "${languages.enterOtp}*"),
                    setError: true,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      return validateWithFixLength(value, 4, languages.enterOtp, languages.enterCompleteOtp);
                    },
                  ),
                ),
                Container(
                  height: deviceHeight * 0.065,
                  alignment: AlignmentDirectional.center,
                  // color: colorMainBackground,
                  margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.025, end: deviceWidth * 0.02, start: deviceWidth * 0.02),
                  child: TextFormFieldCustom(
                    controller: _bloc.passController,
                    useLabelWithBorder: true,
                    decoration: InputDecoration(labelText: "${languages.password}*"),
                    setError: true,
                    setPassword: true,
                    validator: (value) {
                      return passwordValidate(value);
                    },
                  ),
                ),
                Container(
                  height: deviceHeight * 0.065,
                  alignment: AlignmentDirectional.center,
                  // color: colorMainBackground,
                  margin: EdgeInsetsDirectional.only(
                    top: deviceHeight * 0.025,
                    end: deviceWidth * 0.02,
                    start: deviceWidth * 0.02,
                    bottom: deviceHeight * 0.01,
                  ),
                  child: TextFormFieldCustom(
                    controller: _bloc.rePassController,
                    useLabelWithBorder: true,
                    decoration: InputDecoration(labelText: "${languages.confirmPass}*"),
                    setError: true,
                    setPassword: true,
                    validator: (value) {
                      return confirmPasswordValidate(value, _bloc.passController.text);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                    StreamBuilder<ApiResponse<LoginPojo>>(
                        stream: _bloc.subject,
                        builder: (context, snapLoading) {
                          var isLoading = snapLoading.hasData && snapLoading.data!.status == Status.loading;
                          return CustomRoundedButton(
                            context,
                            languages.submit,
                            isLoading
                                ? null
                                : () {
                                    if (_bloc.formKey.currentState!.validate()) {
                                      _bloc.submit(widget.storeId);
                                    }
                                  },
                            setBorder: false,
                            bgColor: colorPrimary,
                            minWidth: 0.15,
                            minHeight: 0.04,
                            fontWeight: FontWeight.w700,
                            textColor: colorWhite,
                            textSize: textSizeSmall,
                            textAlign: TextAlign.center,
                            maxLine: 1,
                            setProgress: isLoading,
                            progressColor: colorWhite,
                            progressStrokeWidth: cpiStrokeWidthSmall,
                            progressSize: cpiSizeSmall,
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
      ),
    );
  }
}

// Path: lib/dialog/editNumberDialog/edit_number_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/customCountryCodePicker/custom_country_code_picker.dart';
import '../../commonView/custom_text_field.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../screen/verificationScreen/otp_verify_dl.dart';
import '../../utils/common_util.dart';
import 'edit_number_dialog_bloc.dart';

class EditNumberDialog extends StatefulWidget {
  const EditNumberDialog({super.key});

  @override
  EditNumberDialogState createState() => EditNumberDialogState();
}

class EditNumberDialogState extends State<EditNumberDialog> {
  late EditNumberDialogBloc _bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bloc = EditNumberDialogBloc(context, this);
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
        backgroundColor: colorMainBackground,
        shape: RoundedRectangleBorder(borderRadius: dialogBorderRadius),
        child: Form(
          key: _bloc.formKey,
          child: Container(
            margin:
                EdgeInsetsDirectional.only(top: deviceHeight * 0.02, start: deviceWidth * 0.03, end: deviceWidth * 0.03, bottom: deviceHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  languages.editNumber,
                  style: bodyText(fontSize: textSizeLarge, fontWeight: FontWeight.w700, textColor: colorBlack),
                ),
                SizedBox(
                  height: deviceHeight * 0.025,
                ),
                TextFormFieldCustom(
                  controller: _bloc.mobileController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  useLabelWithBorder: true,
                  decoration: InputDecoration(labelText: languages.contactNumber),
                  prefix: CustomCountryCodePicker(
                    showDropDownButton: true,
                    flagWidth: deviceHeight * 0.035,
                    showFlag: true,
                    showFlagDialog: true,
                    padding: const EdgeInsets.all(0),
                    dialogSize: Size(deviceWidth * 0.9, deviceHeight * 0.75),
                    textStyle: bodyText(fontSize: textSizeSmall, textColor: colorTextCommon),
                    dialogTextStyle: bodyText(fontSize: textSizeSmall, textColor: colorTextCommon),
                    onChanged: _bloc.changeCountry,
                    onInit: (countryCode) {
                      _bloc.changeCountry(countryCode ?? defaultCountryCode);
                    },
                    initialSelection: defaultCountryCode.name,
                  ),
                  style: bodyText(fontSize: textSizeSmall, textColor: colorTextCommon),
                  setError: true,
                  validator: (value) {
                    return mobileNumberValidate(value);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomRoundedButton(
                      context,
                      languages.cancel,
                      () {
                        Navigator.pop(context, false);
                      },
                      margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.04, bottom: deviceHeight * 0.01),
                      setBorder: true,
                      maxLine: 1,
                      textAlign: TextAlign.center,
                      textSize: textSizeMediumBig,
                      borderWidth: 0.003,
                      textColor: colorPrimary,
                      fontWeight: FontWeight.w700,
                      minHeight: commonBtnHeightSmallest,
                      minWidth: commonBtnWidthSmallest,
                    ),
                    StreamBuilder<ApiResponse<EditNumberPojo>>(
                        stream: _bloc.subject,
                        builder: (context, snapLoading) {
                          var isLoading = snapLoading.hasData && snapLoading.data!.status == Status.loading;
                          return CustomRoundedButton(
                            context,
                            languages.change,
                            isLoading
                                ? null
                                : () {
                                    if (_bloc.formKey.currentState!.validate()) {
                                      _bloc.editNumber();
                                    }
                                  },
                            minWidth: commonBtnWidthSmallest,
                            setBorder: false,
                            minHeight: commonBtnHeightSmallest,
                            fontWeight: FontWeight.w700,
                            textColor: colorWhite,
                            textSize: textSizeMediumBig,
                            textAlign: TextAlign.center,
                            maxLine: 1,
                            bgColor: colorPrimary,
                            progressSize: cpiSizeSmall,
                            progressStrokeWidth: cpiStrokeWidthSmallest,
                            progressColor: colorWhite,
                            setProgress: isLoading,
                            margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.04, bottom: deviceHeight * 0.01, start: deviceWidth * 0.02),
                            padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.005, end: deviceWidth * 0.005),
                          );
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

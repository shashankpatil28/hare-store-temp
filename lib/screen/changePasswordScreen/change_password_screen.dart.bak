// Path: lib/screen/changePasswordScreen/change_password_screen.dart

import 'package:flutter/material.dart';

import '../../commonView/custom_text_field.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/common_util.dart';
import 'change_password_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late ChangePasswordBloc _changePasswordBloc;
  var labelStyle = bodyText(
      fontSize: textSizeMediumBig,
      fontWeight: FontWeight.w600,
      textColor: colorMainLightGray);
  var textStyle =
      bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600);
  var formDivider = deviceHeight * 0.025;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _changePasswordBloc = ChangePasswordBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _changePasswordBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        titleTextStyle: toolbarStyle(),
        title: Text(languages.changePassword),
        leading: const BackButton(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: deviceWidth * 0.04,
                end: deviceWidth * 0.04,
                bottom: deviceHeight * 0.03,
                top: deviceHeight * 0.025,
              ),
              child: Form(
                key: _changePasswordBloc.formKey,
                child: Column(
                  children: [
                    TextFormFieldCustom(
                      decoration: InputDecoration(labelText: languages.oldPass),
                      useLabelWithBorder: false,
                      style: textStyle,
                      controller: _changePasswordBloc.oldPassController,
                      setError: true,
                      setPassword: true,
                      validator: (value) {
                        _changePasswordBloc.buttonHide();
                        return passwordValidate(value);
                      },
                    ),
                    SizedBox(
                      height: formDivider,
                    ),
                    TextFormFieldCustom(
                      decoration: InputDecoration(labelText: languages.newPass),
                      useLabelWithBorder: true,
                      style: textStyle,
                      controller: _changePasswordBloc.newPassController,
                      setError: true,
                      setPassword: true,
                      validator: (value) {
                        _changePasswordBloc.buttonHide();
                        return passwordValidate(value);
                      },
                    ),
                    SizedBox(height: formDivider),
                    TextFormFieldCustom(
                      decoration:
                          InputDecoration(labelText: languages.reEnterPass),
                      useLabelWithBorder: true,
                      style: textStyle,
                      controller: _changePasswordBloc.rePassController,
                      textInputAction: TextInputAction.done,
                      setError: true,
                      setPassword: true,
                      validator: (value) {
                        _changePasswordBloc.buttonHide();
                        return confirmPasswordValidate(
                            value, _changePasswordBloc.newPassController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: StreamBuilder<bool>(
                stream: _changePasswordBloc.submitValid,
                builder: (context, snapEnable) {
                  bool isEnable = snapEnable.data ?? false;
                  return StreamBuilder<ApiResponse<BaseModel>>(
                    stream: _changePasswordBloc.subject,
                    builder: (context, snapLoading) {
                      var isLoading = snapLoading.hasData &&
                          snapLoading.data!.status == Status.loading;
                      return CustomRoundedButton(
                        context,
                        languages.submit,
                        (isLoading || !isEnable)
                            ? null
                            : () {
                                if (_changePasswordBloc.formKey.currentState!
                                    .validate()) {
                                  _changePasswordBloc.submit();
                                }
                              },
                        elevation: deviceAverageSize * smallElevation,
                        progressStrokeWidth: cpiStrokeWidthSmall,
                        progressSize: cpiSizeSmall,
                        progressColor: colorWhite,
                        setProgress: isLoading,
                        minWidth: double.infinity,
                        maxLine: 1,
                        bgColor: colorPrimary,
                        setBorder: false,
                        textAlign: TextAlign.center,
                        textSize: textSizeLarge,
                        textColor: colorWhite,
                        fontWeight: FontWeight.w700,
                        minHeight: commonBtnHeight,
                        margin: EdgeInsetsDirectional.only(
                          start: deviceWidth * 0.035,
                          end: deviceWidth * 0.035,
                          bottom: deviceHeight * 0.03,
                          top: deviceHeight * 0.02,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

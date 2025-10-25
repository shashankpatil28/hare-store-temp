// Path: lib/screen/loginScreen/login_screen.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/customCountryCodePicker/custom_country_code_picker.dart';
import '../../commonView/custom_text_field.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/validator.dart';
import '../../dialog/forgotPasswordDialog/forgot_password_dialog.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import '../signupScreen/signup_screen.dart';
import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc? _bloc;

  var labelStyle = bodyText(
      fontSize: textSizeMediumBig,
      fontWeight: FontWeight.w600,
      textColor: colorMainLightGray);
  var textStyle =
      bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600);
  var formDivider = deviceHeight * 0.015;

  @override
  void didChangeDependencies() {
    _bloc = _bloc ?? LoginBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLoginBg,
      body: _buildLogin(context),
    );
  }

  _buildLogin(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: deviceHeight * 0.05),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: deviceAverageSize * 0.030),
          color: colorLoginBg,
          height: deviceHeight * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  "assets/images/splash_logo.png",
                  fit: BoxFit.contain,
                  height: deviceHeight * 0.15,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: Stack(
            children: [
              Container(color: colorLoginBg),
              Container(
                width: double.infinity,
                height: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.vertical(
                      top: Radius.circular(30)),
                  color: colorWhite,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceHeight * 0.025,
                        vertical: deviceHeight * 0.025),
                    child: Column(
                      children: [
                        Text(
                          languages.welcomeBack,
                          style: bodyText(
                              textColor: colorBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 0.042),
                        ),
                        Text(
                          languages.loginToContinue,
                          style: bodyText(
                              textColor: colorMainLightGray,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: deviceHeight * 0.025),
                        Form(
                          key: _bloc!.formKey,
                          child: Column(
                            children: [
                              // TextFormFieldCustom(
                              //   decoration: InputDecoration(
                              //       labelText: "${languages.contactNumber}*"),
                              //   useLabelWithBorder: true,
                              //   setError: true,
                              //   keyboardType: TextInputType.phone,
                              //   inputFormatters: [
                              //     FilteringTextInputFormatter.digitsOnly
                              //   ],
                              //   prefix: CustomCountryCodePicker(
                              //     showDropDownButton: true,
                              //     flagWidth: deviceHeight * 0.035,
                              //     padding: const EdgeInsets.all(0),
                              //     textStyle: textStyle,
                              //     dialogTextStyle: textStyle,
                              //     onChanged: (v) {
                              //       _bloc?.countryCode = "${v.dialCode}";
                              //     },
                              //     initialSelection: defaultCountryCode.code,
                              //   ),
                              //   style: textStyle,
                              //   textAlignVertical: TextAlignVertical.center,
                              //   controller: _bloc!.contactNumber,
                              //   validator: (value) {
                              //     _bloc?.buttonHide();
                              //     return mobileNumberValidate(value);
                              //   },
                              // ),
                              TextFormFieldCustom(
                                  decoration: InputDecoration(
                                      labelText: "${languages.email}*"),
                                  useLabelWithBorder: true,
                                  setError: true,
                                  keyboardType: TextInputType.emailAddress,
                                  style: textStyle,
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: _bloc!.contactNumber,
                                  validator: (value) {
                                    // _bloc?.buttonHide();
                                    return emailValidate(value);
                                  }),
                              SizedBox(height: deviceHeight * 0.025),
                              TextFormFieldCustom(
                                decoration: InputDecoration(
                                    labelText: "${languages.password}*"),
                                useLabelWithBorder: true,
                                style: textStyle,
                                textInputAction: TextInputAction.done,
                                controller: _bloc!.password,
                                setError: true,
                                setPassword: true,
                                validator: (value) {
                                  _bloc?.buttonHide();
                                  return validateEmptyField(
                                      value, languages.enterPass);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: formDivider * 2,
                        ),
                        StreamBuilder<bool>(
                            stream: _bloc!.submitValid,
                            builder: (context, snap) {
                              bool isEnable = snap.data ?? false;
                              return StreamBuilder<ApiResponse>(
                                  stream: _bloc!.loginAuthSubject,
                                  builder: (context, snapLoading) {
                                    var isLoading = snapLoading.hasData &&
                                        snapLoading.data?.status ==
                                            Status.loading;
                                    return CustomRoundedButton(
                                      context,
                                      languages.login,
                                      (isLoading || !isEnable)
                                          ? null
                                          : () {
                                              _bloc?.loginAuthentication();
                                            },
                                      setProgress: isLoading,
                                      fontWeight: FontWeight.bold,
                                      textSize: textSizeLarge,
                                      minHeight: commonBtnHeight,
                                      minWidth: double.infinity,
                                    );
                                  });
                            }),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: deviceHeight * 0.02),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return const ForgotPasswordDialog();
                                  });
                            },
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                "${languages.forgotPassword}?",
                                style: bodyText(fontWeight: FontWeight.w600)
                                    .copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: deviceHeight * 0.02),
                          child: RichText(
                            text: TextSpan(
                                text: languages.dontHaveAccount,
                                style: bodyText(fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                      text: " ${languages.registerNow}",
                                      style: bodyText(
                                          fontSize: textSizeBig,
                                          fontWeight: FontWeight.w600,
                                          textColor: colorPrimary),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          openScreenWithReplacePrevious(
                                              context, const SignUpScreen());
                                        })
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

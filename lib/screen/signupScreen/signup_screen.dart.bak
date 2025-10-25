// Path: lib/screen/signupScreen/signup_screen.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/customCountryCodePicker/custom_country_code_picker.dart';
import '../../commonView/custom_text_field.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/validator.dart';
import '../../network/api_base_helper.dart';
import '../../network/api_data.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import '../loginScreen/login_screen.dart';
import '../../network/endpoints.dart';
import 'signup_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  var textStyle = bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600);
  var formDivider = deviceHeight * 0.025;
  SignUpBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc = _bloc ?? SignUpBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        openScreenWithClearPrevious(context, const LoginScreen());
        return true;
      },
      child: Scaffold(
        backgroundColor: colorPrimaryDark,
        appBar: AppBar(
          titleTextStyle: toolbarStyle(textColor: colorWhite),
          iconTheme: const IconThemeData(color: colorWhite),
          backgroundColor: colorPrimary,
          title: Text(languages.register),
          leading: const BackButton(),
          elevation: 0,
        ),
        body: _buildSignUp(context),
      ),
    );
  }

  _buildSignUp(BuildContext context) {
    return Column(
      children: [
        Container(
          height: deviceHeight * 0.02,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[colorPrimaryDark, colorPrimary],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(30)), color: colorWhite),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceHeight * 0.025, vertical: deviceHeight * 0.025),
                child: Column(
                  children: [
                    Form(
                      key: _bloc!.formKey,
                      child: Column(
                        children: [
                          TextFormFieldCustom(
                            decoration: InputDecoration(labelText: "${languages.fullName}*"),
                            useLabelWithBorder: true,
                            style: textStyle,
                            controller: _bloc!.fullNameController,
                            setError: true,
                            validator: (value) {
                              _bloc?.buttonHide();
                              return fullNameValidate(value);
                            },
                          ),
                          SizedBox(height: formDivider),
                          TextFormFieldCustom(
                            decoration: InputDecoration(labelText: "${languages.email}*"),
                            useLabelWithBorder: true,
                            style: textStyle,
                            keyboardType: TextInputType.emailAddress,
                            controller: _bloc!.emailController,
                            setError: true,
                            validator: (value) {
                              _bloc?.buttonHide();
                              return emailValidate(value);
                            },
                          ),
                          SizedBox(height: formDivider),
                          TextFormFieldCustom(
                            decoration: InputDecoration(labelText: "${languages.password}*"),
                            useLabelWithBorder: true,
                            style: textStyle,
                            controller: _bloc!.passController,
                            setError: true,
                            setPassword: true,
                            validator: (value) {
                              _bloc?.buttonHide();
                              return passwordValidate(value);
                            },
                          ),
                          SizedBox(height: formDivider),
                          TextFormFieldCustom(
                            decoration: InputDecoration(labelText: "${languages.reEnterPass}*"),
                            useLabelWithBorder: true,
                            style: textStyle,
                            controller: _bloc!.rePassController,
                            setError: true,
                            setPassword: true,
                            validator: (value) {
                              _bloc?.buttonHide();
                              return confirmPasswordValidate(value, _bloc!.passController.text);
                            },
                          ),
                          SizedBox(height: formDivider),
                          TextFormFieldCustom(
                            decoration: InputDecoration(labelText: "${languages.contactNumber}*"),
                            useLabelWithBorder: true,
                            setError: true,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            prefix: CustomCountryCodePicker(
                              showDropDownButton: true,
                              flagWidth: deviceHeight * 0.035,
                              padding: const EdgeInsets.all(0),
                              textStyle: textStyle,
                              onChanged: (v) {
                                _bloc?.countryCode = (v.dialCode);
                              },
                              initialSelection: defaultCountryCode.code,
                            ),
                            style: textStyle,
                            textAlignVertical: TextAlignVertical.center,
                            controller: _bloc!.mobileController,
                            validator: (value) {
                              _bloc?.buttonHide();
                              return mobileNumberValidate(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<bool>(
                        stream: _bloc!.acceptTermsController,
                        builder: (context, snap) {
                          return Row(
                            children: [
                              Flexible(
                                flex: 0,
                                child: Checkbox(
                                  tristate: false,
                                  value: snap.data ?? false,
                                  onChanged: (value) {
                                    _bloc?.acceptTermsController.add(value ?? false);
                                    _bloc?.buttonHide();
                                  },
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.03),
                                  child: RichText(
                                    // textAlign: TextAlign.center,
                                    text: TextSpan(text: languages.signUpText, style: bodyText(fontWeight: FontWeight.w600), children: [
                                      TextSpan(
                                          text: "\n${languages.termAndConditionUse}",
                                          style: bodyText(textColor: colorPrimary, fontWeight: FontWeight.w600).copyWith(
                                            decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              openUrl(ApiBaseHelper().baseUrl + EndPoint.endPointTermsAndConditions);
                                            }),
                                      TextSpan(text: " ${languages.ofUse}", style: bodyText(fontWeight: FontWeight.w600))
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                    StreamBuilder<bool>(
                        stream: _bloc!.submitValid,
                        builder: (context, snapshot) {
                          bool isEnable = snapshot.data ?? false;
                          return StreamBuilder<ApiResponse>(
                              stream: _bloc!.signUpSubject,
                              builder: (context, snapLoading) {
                                var isLoading = snapLoading.hasData && snapLoading.data?.status == Status.loading;
                                return CustomRoundedButton(
                                  context,
                                  languages.register,
                                  (isLoading || !isEnable)
                                      ? null
                                      : () {
                                          _bloc?.signUp();
                                        },
                                  fontWeight: FontWeight.bold,
                                  setProgress: isLoading,
                                  minHeight: commonBtnHeight,
                                  textSize: textSizeLarge,
                                  minWidth: double.infinity,
                                );
                              });
                        }),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.02),
                      child: RichText(
                        text: TextSpan(text: languages.alreadyHaveAccount, style: bodyText(fontWeight: FontWeight.w600), children: [
                          TextSpan(
                              text: " ${languages.loginHere}",
                              style: bodyText(fontSize: textSizeBig, fontWeight: FontWeight.w600, textColor: colorPrimary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  openScreenWithClearPrevious(context, const LoginScreen());
                                })
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Gender extends StatefulWidget {
  final Function(int) selection;

  const Gender({super.key, required this.selection});

  @override
  State<StatefulWidget> createState() => GenderState();
}

class GenderState extends State<Gender> {
  GenderEnum _gender = GenderEnum.male;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(languages.gender),
        GestureDetector(
          onTap: () {
            setState(() {
              _gender = GenderEnum.male;
              widget.selection(genderTypeMale);
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: GenderEnum.male,
                groupValue: _gender,
                onChanged: (gender) {
                  widget.selection(genderTypeMale);
                  setState(() {
                    _gender = gender ?? GenderEnum.male;
                  });
                },
              ),
              Text(languages.male)
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _gender = GenderEnum.female;
              widget.selection(genderTypeFemale);
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.022),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: GenderEnum.female,
                  groupValue: _gender,
                  onChanged: (gender) {
                    widget.selection(genderTypeFemale);
                    setState(() {
                      _gender = gender ?? GenderEnum.female;
                    });
                  },
                ),
                Text(languages.female)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

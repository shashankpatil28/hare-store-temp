// Path: lib/screen/verificationScreen/otp_screen.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../commonView/count_down_timer.dart';
import '../../commonView/my_widgets.dart';
import '../../dialog/editNumberDialog/edit_number_dialog.dart';
import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/common_util.dart';
import '../loginScreen/login_screen.dart';
import 'otp_screen_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  late OtpScreenBloc _otpScreenBloc;
  Timer? timer;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    _otpScreenBloc = OtpScreenBloc(context, this);
    if (isDemoApp) {
      _otpScreenBloc.changeOtp("1234");
      /*timer = Timer(const Duration(seconds: 3), () {
        _otpScreenBloc.changeOtp("1234");
        _otpScreenBloc.verify();
      });*/
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }
    _otpScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await prefSetInt(prefStoreId, 0);
        if (mounted) {
          openScreenWithClearPrevious(context, const LoginScreen());
          // openScreenWithClearPrevious(context, const LoginAndSignUp());
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          titleTextStyle: toolbarStyle(),
          title: Text(languages.verification),
          leading: const BackButton(),
        ),
        body: _buildOtpVerify(context),
      ),
    );
  }

  Widget _buildOtpVerify(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: deviceHeight * 0.05),
          AspectRatio(
            aspectRatio: 5,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SvgPicture.asset(
                  "assets/svgs/account_verification_1.svg",
                ),
                SvgPicture.asset(
                  "assets/svgs/account_verification_2.svg",
                  colorFilter: const ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                ),
              ],
            ),
          ),
          SizedBox(height: deviceHeight * 0.03),
          Text(
            languages.enterVerfCode,
            textAlign: TextAlign.center,
            style: bodyText(fontSize: textSizeLargest, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.06, end: deviceWidth * 0.06, top: deviceHeight * 0.015),
            child: Text(
              languages.enterVerfCodeMsg,
              textAlign: TextAlign.center,
              style: bodyText(fontSize: textSizeSmallest),
            ),
          ),

          otpField(_otpScreenBloc),
          Container(
            margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.04, end: deviceWidth * 0.04, top: deviceHeight * 0.015),
            child: Text(
              languages.resendEmailMsg,
              textAlign: TextAlign.center,
              style: bodyText(fontSize: textSizeSmall, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.05, end: deviceWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: CustomRoundedButton(
                    context,
                    languages.editNumber,
                    () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const EditNumberDialog();
                          }).then(
                        (value) {
                          if (value ?? false) {
                            _otpScreenBloc.resendOTPStream.add(false);
                          }
                        },
                      );
                    },
                    fontWeight: FontWeight.w700,
                    bgColor: colorWhite,
                    minHeight: commonBtnHeight,
                    textSize: textSizeMediumBig,
                    textColor: colorTextCommon,
                    minWidth: double.infinity,
                    margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.015, top: deviceHeight * 0.05),
                    padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.01, end: deviceWidth * 0.01),
                  ),
                ),
                resendButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  otpField(OtpScreenBloc bloc) => StreamBuilder<String>(
        stream: bloc.otptValue,
        builder: (context, snap) {
          if (snap.hasData) {
            _textEditingController.value = _textEditingController.value.copyWith(text: snap.data ?? "");
          }
          return Column(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.05, start: deviceWidth * 0.2, end: deviceWidth * 0.2),
                child: PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  controller: _textEditingController,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('^[0-9]*\$'))],
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(deviceAverageSize * 0.003),
                    fieldHeight: deviceAverageSize * 0.08,
                    fieldWidth: deviceAverageSize * 0.08,
                    borderWidth: 0,
                    activeColor: colorMainBackground,
                    activeFillColor: colorMainBackground,
                    selectedFillColor: colorMainBackground,
                    selectedColor: colorMainBackground,
                    inactiveColor: colorMainBackground,
                    inactiveFillColor: colorMainBackground,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onChanged: bloc.changeOtp,
                  beforeTextPaste: (text) {
                    return false;
                  },
                  appContext: context,
                ),
              ),
              StreamBuilder<ApiResponse<BaseModel>>(
                stream: bloc.subjectVerify,
                builder: (context, snapLoading) {
                  var isLoading = snapLoading.hasData && snapLoading.data?.status == Status.loading;
                  return CustomRoundedButton(
                    context,
                    languages.verify,
                    ((!(snap.hasData && snap.data!.length == 4) || isLoading)
                        ? null
                        : () {
                            bloc.verify();
                          }),
                    setProgress: isLoading,
                    minHeight: commonBtnHeight,
                    textSize: textSizeBig,
                    minWidth: commonBtnWidthSmall,
                    margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.03, bottom: deviceHeight * 0.04),
                    padding: EdgeInsetsDirectional.zero,
                  );
                },
              ),
            ],
          );
        },
      );

  resendButton() => StreamBuilder<bool>(
      stream: _otpScreenBloc.resendOTPStream,
      builder: (context, snapResendOTP) {
        bool resendOTP = snapResendOTP.data ?? false;
        return StreamBuilder<ApiResponse<BaseModel>>(
          stream: _otpScreenBloc.subjectResend,
          builder: (context, snapLoading) {
            var isLoading = snapLoading.hasData && snapLoading.data?.status == Status.loading;
            return resendOTP
                ? Expanded(
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.015, top: deviceHeight * 0.05),
                      padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.01, end: deviceWidth * 0.01),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              languages.resendOtpIn,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: bodyText(fontSize: textSizeSmallest, fontWeight: FontWeight.normal, textColor: colorTextCommon),
                            ),
                          ),
                          SizedBox(width: deviceWidth * 0.01),
                          CountDownTimer(
                            secondsRemaining: 60,
                            whenTimeExpires: () {
                              _otpScreenBloc.resendOTPStream.add(false);
                            },
                            countDownTimerStyle: bodyText(fontSize: textSizeRegular, fontWeight: FontWeight.w600, textColor: colorPrimary),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: CustomRoundedButton(
                      context,
                      languages.resendOtp,
                      isLoading
                          ? null
                          : () {
                              _otpScreenBloc.resendOtp();
                            },
                      setProgress: isLoading,
                      progressColor: colorPrimary,
                      progressSize: cpiSizeSmallest,
                      fontWeight: FontWeight.w700,
                      bgColor: colorWhite,
                      minHeight: commonBtnHeight,
                      textSize: textSizeMediumBig,
                      textColor: colorTextCommon,
                      minWidth: double.infinity,
                      margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.015, top: deviceHeight * 0.05),
                      padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.01, end: deviceWidth * 0.01),
                    ),
                  );
          },
        );
      });
}

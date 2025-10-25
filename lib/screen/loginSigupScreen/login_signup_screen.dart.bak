// Path: lib/screen/loginSigupScreen/login_signup_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../commonView/my_widgets.dart';
import '../../utils/common_util.dart';
import '../loginScreen/login_screen.dart';
import '../signupScreen/signup_screen.dart';

class LoginAndSignUp extends StatelessWidget {
  const LoginAndSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/splash_bg.png"), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: deviceHeight * 0.25),
              Expanded(
                flex: 4,
                child: AspectRatio(
                  aspectRatio: 0.75,
                  child: Image.asset(
                    "assets/images/splash_img.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: deviceHeight * 0.1),
              Expanded(
                flex: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: deviceHeight * 0.005),
                    Text(
                      languages.splTagLine,
                      textAlign: TextAlign.start,
                      style: bodyText(textColor: colorWhite, fontSize: textSizeBig).copyWith(letterSpacing: .2),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomRoundedButton(
                        context,
                        languages.register,
                        () {
                          openScreen(context, const SignUpScreen());
                        },
                        fontWeight: FontWeight.bold,
                        textSize: textSizeLarge,
                        minWidth: deviceWidth,
                        bgColor: colorWhite,
                        textColor: colorPrimary,
                        minHeight: commonBtnHeight,
                        margin: EdgeInsetsDirectional.only(
                          start: deviceWidth * 0.07,
                          end: deviceWidth * 0.035,
                          bottom: deviceHeight * 0.05,
                          top: deviceHeight * 0.08,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CustomRoundedButton(
                        context,
                        languages.login,
                        () {
                          openScreen(context, const LoginScreen());
                        },
                        fontWeight: FontWeight.bold,
                        textSize: textSizeLarge,
                        minWidth: deviceWidth,
                        minHeight: commonBtnHeight,
                        bgColor: colorWhite,
                        textColor: colorPrimary,
                        margin: EdgeInsetsDirectional.only(
                          start: deviceWidth * 0.035,
                          end: deviceWidth * 0.07,
                          bottom: deviceHeight * 0.05,
                          top: deviceHeight * 0.08,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: GestureDetector(
                  onTap: () {
                    launchUrlString("https://whitelabelfox.com/");
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isDemoApp)
                        Text(
                          languages.productBy,
                          textAlign: TextAlign.start,
                          style: bodyText(fontSize: textSizeRegular, fontWeight: FontWeight.w500).copyWith(letterSpacing: .3),
                        ),
                      SizedBox(height: deviceHeight * 0.01),
                      if (isDemoApp)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/wlf_icon.svg",
                              width: deviceWidth * 0.1,
                            ),
                            SizedBox(width: deviceWidth * 0.02),
                            SvgPicture.asset(
                              "assets/svgs/wlf_text.svg",
                              width: deviceWidth * 0.4,
                              colorFilter: const ColorFilter.mode(colorTextCommon, BlendMode.srcIn),
                            ),
                          ],
                        ),
                      SizedBox(height: deviceHeight * 0.01),
                      appVersionName(textColor: colorTextCommon),
                      SizedBox(height: deviceHeight * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

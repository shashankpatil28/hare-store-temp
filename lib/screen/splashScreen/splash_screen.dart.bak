// Path: lib/screen/splashScreen/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/common_util.dart';
import 'splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashBloc? _bloc;
  // AssetImage? _image;

  @override
  void initState() {
    super.initState();
    // _image = _image ?? const AssetImage("assets/gifs/splash_animation.gif");
  }

  @override
  void didChangeDependencies() {
    if (mounted) {
      _bloc = _bloc ?? SplashBloc(context,this);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    // _image?.evict();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/splash_bg.png"), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: Image.asset(
                  'assets/images/splash_logo.png',
                  width: deviceWidth * 0.4,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/gifs/splash_loading.gif",
                      color: colorPrimary,
                      height: deviceHeight * 0.05,
                      width: deviceWidth * 0.09,
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    appVersionName(textColor: colorPrimary),
                    SizedBox(height: deviceHeight * 0.01),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

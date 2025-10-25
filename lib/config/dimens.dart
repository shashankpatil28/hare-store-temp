// Path: lib/config/dimens.dart

import 'package:flutter/material.dart';

double deviceWidth = 0.0;
double deviceHeight = 0.0;
double deviceAverageSize = 0.0;
double statusHeight=0.0;
double textScaleFactorOf=0.0;


double textSizeSmallest = 0.023;
double textSizeSmall = 0.025;
double textSizeRegular = 0.026;
double textSizeMediumBig = 0.027;
double textSizeBig = 0.029;
double textSizeLarge = 0.030;
double textSizeLargest = 0.034;

//elevation
double smallElevation = 0.005;

double dialougePadding = 0.02;

double buttonMinWidth = deviceWidth * 0.45;
double dialogButtonMinWidth = deviceWidth * 0.2;
double buttonPaddingSmall = deviceAverageSize * 0.01;
double buttonPadding = deviceAverageSize * 0.015;
double dialogPadding = deviceAverageSize * 0.02;


//Common Button Height
double commonBtnHeightBig = 0.07;
double commonBtnHeight = 0.065;
double commonBtnHeightMedium = 0.053;
double commonBtnHeightSmall = 0.048;
double commonBtnHeightSmallest = 0.04;
double commonBtnHeightVerySmall = 0.010;
double commonBtnWidthSmall = 0.4;
double commonBtnWidth = 0.5;
double commonBtnWidthBig = 0.55;
double commonBtnWidthLargest = 0.6;
double commonBtnWidthSmallest = 0.25;
double commonBtnWidthSmallMedium = 0.45;

//Common CircularProgressIndicator
double cpiStrokeWidthRegular = 0.004;
double cpiStrokeWidthSmall = 0.003;
double cpiStrokeWidthSmallest = 0.0022;

double cpiSizeSmallest = 0.022;
double cpiSizeSmall = 0.03;
double cpiSizeRegular = 0.035;
double cpiSizeMediumBig = 0.04;




//Common Shape Radius
Radius topLeftRadius = Radius.circular(deviceAverageSize * 0.008);
Radius topRightRadius = Radius.circular(deviceAverageSize * 0.008);
Radius bottomLeftRadius = Radius.circular(deviceAverageSize * 0.008);
Radius bottomRightRadius = Radius.circular(deviceAverageSize * 0.008);

//Common BottomSheet  Radius
Radius topLeftRadiusBs = Radius.circular(deviceAverageSize * 0.05);
Radius topLeftRadiusMediumBs = Radius.circular(deviceAverageSize * 0.035);
Radius topRightRadiusBs = Radius.circular(deviceAverageSize * 0.05);
Radius topRightRadiusMediumBs = Radius.circular(deviceAverageSize * 0.035);

//Common Status Radius
Radius topLeftRadiusStatus = Radius.circular(deviceAverageSize * 0.05);
Radius bottomLeftRadiusStatus = Radius.circular(deviceAverageSize * 0.05);
Radius topRightRadiusStatus = Radius.circular(deviceAverageSize * 0.05);
Radius bottomRightRadiusStatus = Radius.circular(deviceAverageSize * 0.05);

//Common Dialog
BorderRadius dialogBorderRadius = BorderRadius.circular(deviceAverageSize * 0.02);
EdgeInsets dialogPending = EdgeInsets.all(deviceAverageSize * 0.028);

var textFormFieldPadding = EdgeInsets.symmetric(vertical: deviceAverageSize * 0.010,horizontal:  deviceAverageSize * 0.010);

Radius zeroRadius = Radius.zero;

double iconSize = deviceAverageSize * 0.031;
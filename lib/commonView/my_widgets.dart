// Path: lib/commonView/my_widgets.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/common_util.dart';

class CustomRoundedButton extends StatelessWidget {
  final String text;
  final GestureTapCallback? onPressed;
  final Color? bgColor;
  final Color? textColor;
  final Color? progressColor;
  final Color? borderColor;
  final Widget? icon;
  final Widget? widget;
  final double? textSize;
  final double? progressSize;
  final double? progressStrokeWidth;
  final double? elevation;
  final double? borderWidth;
  final bool setBorder;
  final bool setProgress;

  final int maxLine;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final RoundedRectangleBorder? roundedRectangleBorder;
  final EdgeInsetsDirectional margin;
  final EdgeInsetsDirectional padding;
  final MaterialTapTargetSize materialTapTargetSize;
  final double minHeight;
  final double minWidth;

  const CustomRoundedButton(
    BuildContext context,
    this.text,
    this.onPressed, {
    Key? key,
    this.bgColor,
    this.textColor,
    this.progressColor,
    this.icon,
    this.widget,
    this.textSize,
    this.progressSize,
    this.progressStrokeWidth,
    this.elevation,
    this.borderWidth,
    this.setBorder = false,
    this.setProgress = false,
    this.maxLine = 1,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.roundedRectangleBorder,
    this.margin = EdgeInsetsDirectional.zero,
    this.padding = EdgeInsetsDirectional.zero,
    this.materialTapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.minHeight = 0.0,
    this.minWidth = 0.0,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? mainBgColor = bgColor ?? colorPrimary;
    mainBgColor = onPressed == null ? lighten(mainBgColor) : mainBgColor;

    return Container(
      margin: margin,
      child: CustomBorderButton(
        onPressed: setProgress ? null : onPressed,
        border: roundedRectangleBorder ??
            RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                    topStart: topRightRadius, topEnd: topLeftRadius, bottomStart: bottomRightRadius, bottomEnd: bottomLeftRadius)),
        borderColor: mainBgColor,
        bgColor: setBorder ? null : mainBgColor,
        icon: icon,
        minHeight: minHeight,
        minWidth: minWidth,
        setBorder: setBorder,
        tapTargetSize: materialTapTargetSize,
        padding: padding,
        elevation: elevation,
        borderWidth: borderWidth,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            setProgress
                ? Flexible(
                    child: SizedBox(
                      width: deviceHeight * (progressSize ?? cpiSizeSmall),
                      height: deviceHeight * (progressSize ?? cpiSizeSmall),
                      child: CircularProgressIndicator(
                        strokeWidth: deviceAverageSize * (progressStrokeWidth ?? cpiStrokeWidthSmall),
                        valueColor: AlwaysStoppedAnimation<Color>(progressColor ?? (setBorder ? bgColor ?? colorPrimary : colorWhite)),
                      ),
                    ),
                  )
                : Flexible(
                    child: widget ??
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (icon != null) Flexible(child: Container(margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.02), child: icon)),
                            Flexible(
                              child: Text(
                                text,
                                overflow: TextOverflow.ellipsis,
                                maxLines: maxLine,
                                textAlign: textAlign,
                                style: bodyText(
                                    fontSize: textSize ?? textSizeRegular,
                                    fontWeight: fontWeight,
                                    textColor: textColor ?? (setBorder ? bgColor ?? colorPrimary : colorWhite)),
                              ),
                            ),
                          ],
                        ),
                  ),
          ],
        ),
      ),
    );
  }
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

class CustomBorderButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final Widget? child;
  final Widget? icon;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderWidth;
  final double minHeight;
  final double minWidth;
  final double? elevation;
  final EdgeInsetsDirectional padding;
  final bool setBorder;
  final MaterialTapTargetSize tapTargetSize;
  final RoundedRectangleBorder? border;

  const CustomBorderButton({
    Key? key,
    this.onPressed,
    this.child,
    this.bgColor,
    this.borderColor,
    this.borderWidth,
    this.border,
    this.icon,
    this.minHeight = 0,
    this.setBorder = false,
    this.padding = EdgeInsetsDirectional.zero,
    this.minWidth = 0,
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadiusDirectional =
        BorderRadiusDirectional.only(topStart: topRightRadius, topEnd: topLeftRadius, bottomStart: bottomRightRadius, bottomEnd: bottomLeftRadius);
    return !setBorder
        ? ElevatedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: bgColor ?? colorPrimary,
              tapTargetSize: tapTargetSize,
              elevation: elevation,
              padding: padding,
              minimumSize: Size(deviceWidth * minWidth, deviceHeight * minHeight),
              shape: border ?? RoundedRectangleBorder(borderRadius: borderRadiusDirectional),
            ),
            onPressed: onPressed != null
                ? () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    onPressed?.call();
                  }
                : null,
            child: child,
          )
        : OutlinedButton(
            style: OutlinedButton.styleFrom(
              tapTargetSize: tapTargetSize,
              minimumSize: Size(deviceWidth * minWidth, deviceHeight * minHeight),
              padding: padding,
              foregroundColor: bgColor ?? colorPrimary,
              shape: border ?? RoundedRectangleBorder(borderRadius: borderRadiusDirectional),
              side: BorderSide(color: borderColor ?? colorPrimary, width: deviceAverageSize * (borderWidth ?? 0.002)),
            ),
            onPressed: onPressed != null
                ? () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    onPressed?.call();
                  }
                : null,
            child: child ?? Container(),
          );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;
  final Color? color;
  final double? size;
  final double? strokeWidth;

  const Loading({Key? key, this.loadingMessage = "", this.color, this.size, this.strokeWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size ?? deviceAverageSize * 0.03,
            height: size ?? deviceAverageSize * 0.03,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth ?? deviceAverageSize * 0.005,
              valueColor: AlwaysStoppedAnimation<Color>(color ?? colorPrimary),
            ),
          ),
          if (loadingMessage.isNotEmpty) Text(loadingMessage)
        ],
      ),
    );
  }
}

class EmptyData extends StatelessWidget {
  final String? image;
  final String loadingMessage;
  final Color? color;
  final double? size;

  const EmptyData({Key? key, this.loadingMessage = "", this.color, this.size, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: deviceAverageSize * 0.18,
                width: deviceAverageSize * 0.18,
                child: SvgPicture.asset(
                  image ?? "assets/svgs/no_data_found.svg",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              if (loadingMessage.isNotEmpty)
                Text(
                  loadingMessage,
                  style: bodyText(),
                  textAlign: TextAlign.center,
                )
            ],
          ),
        ],
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function()? onRetryPressed;

  const Error({Key? key, this.errorMessage = "", this.onRetryPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: bodyText(
              textColor: Colors.red,
              fontSize: textSizeRegular,
            ),
          ),
          const SizedBox(height: 8),
          IconButton(
              onPressed: onRetryPressed,
              icon: const Icon(
                Icons.refresh,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}

class Retry extends StatelessWidget {
  final Function()? onRetryPressed;
  final Color? color;
  final double? iconSize;

  const Retry({Key? key, this.onRetryPressed, this.color, this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRetryPressed,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Icon(
                Icons.refresh,
                color: color ?? Colors.red,
                size: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

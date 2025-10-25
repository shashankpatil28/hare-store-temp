// Path: lib/dialog/simple_dialog_box.dart

import 'package:flutter/material.dart';

import '../commonView/my_widgets.dart';
import '../utils/common_util.dart';

class SimpleDialogBox extends StatefulWidget {
  final String title;
  final String? descriptions;
  final String positiveButton;
  final String? negativeButton;
  final bool progress;
  final Widget? widget;
  final Color? color;
  final Color? dialogColor;
  final Function() positiveClick;
  final Function()? negativeClick;
  final TextStyle? titleTextStyle;

  const SimpleDialogBox(
      {Key? key,
      required this.title,
      this.descriptions,
      required this.positiveButton,
      required this.positiveClick,
      this.negativeClick,
      this.negativeButton,
      this.dialogColor,
      this.widget,
      this.color,
      this.titleTextStyle,
      this.progress = false})
      : super(key: key);

  @override
  SimpleDialogBoxState createState() => SimpleDialogBoxState();
}

class SimpleDialogBoxState extends State<SimpleDialogBox> {
  var padding = deviceAverageSize * 0.025;
  var sidePadding = deviceAverageSize * 0.027;
  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding),
        ),
        elevation: deviceAverageSize * 0.015,
        insetPadding: EdgeInsets.all(dialogPadding),
        backgroundColor: widget.dialogColor ?? Colors.white,
        child: contentBox(context),
      ),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsetsDirectional.only(end: sidePadding, top: padding, start: sidePadding, bottom: padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: double.maxFinite,
            child: Text(
              widget.title,
              style: widget.titleTextStyle ??
                  bodyText(
                    fontSize: textSizeMediumBig,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(
            height: padding / 2,
          ),
          if (widget.descriptions != null)
            SizedBox(
              width: double.maxFinite,
              child: Text(
                widget.descriptions!,
                style: bodyText(),
              ),
            ),
          if (widget.widget != null)
            Container(
              margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.015),
              child: widget.widget,
            ),
          SizedBox(
            height: deviceHeight * 0.035,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.negativeButton != null)
                SizedBox(
                  height: deviceHeight * 0.04,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.006),
                      child: CustomRoundedButton(
                        context,
                        "${widget.negativeButton}",
                        () {
                          Navigator.pop(context, false);
                          if (widget.negativeClick != null) {
                            widget.negativeClick!();
                          }
                        },
                        setBorder: true,
                        minWidth: 0.2,
                        minHeight: 0.04,
                        fontWeight: FontWeight.w600,
                        textSize: textSizeSmall,
                      )),
                ),
              SizedBox(
                height: deviceHeight * 0.04,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.006),
                    child: CustomRoundedButton(
                      context,
                      widget.positiveButton,
                      () {
                        setState(() {
                          isLoad = true;
                        });
                        widget.positiveClick();
                      },
                      minWidth: 0.2,
                      minHeight: 0.04,
                      setProgress: (widget.progress && isLoad),
                      bgColor: widget.color,
                      fontWeight: FontWeight.w600,
                      textSize: textSizeSmall,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

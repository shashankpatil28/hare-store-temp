// Path: lib/commonView/custom_person_detail.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/common_util.dart';
import 'image_with_placeholder.dart';

class CustomPersonDetail extends StatefulWidget {
  final String personName;
  final String? personImage;
  final String? personContact;
  final GestureTapCallback? onPressedCall;
  final GestureTapCallback? onPressedChat;
  final Widget? child;
  final Widget? child1;
  final Widget? imgErrorHolder;

  const CustomPersonDetail({
    Key? key,
    required this.personName,
    this.personImage,
    this.imgErrorHolder,
    this.onPressedCall,
    this.onPressedChat,
    this.personContact,
    this.child1,
    this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomPersonDetailState();
}

class CustomPersonDetailState extends State<CustomPersonDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool validURL = Uri.parse(widget.personImage ?? "").isAbsolute;

    final String? img = validURL ? widget.personImage : null;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(deviceAverageSize * 0.012),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.child != null) widget.child!,
            Row(
              children: [
                ImageWithPlaceholder(
                  image: NetworkImage(img ?? ""),
                  placeholder: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Image.asset(
                      "assets/images/ic_login_logo.png",
                      fit: BoxFit.scaleDown,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  errorHolder: widget.imgErrorHolder ?? Container(),
                  radius: deviceAverageSize * 0.1,
                  isCircular: true,
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          widget.personName,
                          style: bodyText(),
                        ),
                      ),
                      widget.child1 ??
                          Row(
                            children: [
                              Icon(
                                Icons.call,
                                size: deviceAverageSize * textSizeSmall,
                                color: colorTextCommonLight,
                              ),
                              Expanded(
                                child: Text(widget.personContact ?? "" "+00 000-000-000",
                                    style: bodyText(textColor: colorTextCommonLight, fontSize: textSizeSmall)),
                              )
                            ],
                          ),
                    ],
                  ),
                )),
                if (widget.onPressedChat != null)
                  Container(
                    margin: EdgeInsets.all(deviceAverageSize * 0.004),
                    child: FloatingActionButton(
                      elevation: deviceAverageSize * 0.005,
                      mini: true,
                      heroTag: widget.personContact,
                      onPressed: widget.onPressedChat,
                      child: FaIcon(
                        FontAwesomeIcons.solidCommentDots,
                        size: deviceAverageSize * textSizeLargest,
                        color: colorWhite,
                      ),
                    ),
                  ),
                if (widget.onPressedCall != null)
                  Container(
                    margin: EdgeInsets.all(deviceAverageSize * 0.004),
                    child: FloatingActionButton(
                      mini: true,
                      elevation: deviceAverageSize * 0.005,
                      // set it to true
                      heroTag: widget.personName,
                      onPressed: widget.onPressedCall,
                      child: Icon(
                        Icons.phone,
                        size: deviceAverageSize * textSizeLargest,
                        color: colorWhite,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

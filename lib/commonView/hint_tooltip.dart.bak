// Path: lib/commonView/hint_tooltip.dart

import 'package:flutter/material.dart';

import '../utils/common_util.dart';

class HintTooltip extends StatefulWidget {
  final String message;

  const HintTooltip({super.key, required this.message});

  @override
  HintTooltipState createState() => HintTooltipState();
}

class HintTooltipState extends State<HintTooltip> {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.message,
      key: globalKey,
      child: IconButton(
        icon: Icon(
          Icons.error,
          color: Colors.red,
          size: deviceAverageSize * 0.035,
        ),
        onPressed: () {
          final dynamic tooltip = globalKey.currentState;
          tooltip.ensureTooltipVisible();
          _startTimer(tooltip);
        },
      ),
    );
  }

  void _startTimer(dynamic tooltip) async {
    await Future.delayed(const Duration(seconds: 3));
    tooltip.deactivate();
  }
}

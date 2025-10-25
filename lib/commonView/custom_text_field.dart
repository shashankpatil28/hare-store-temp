// Path: lib/commonView/custom_text_field.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../utils/common_util.dart';
import '../utils/keyboard_done_widget.dart';

class TextFormFieldCustom extends StatefulWidget {
  final String? hint;
  final bool setError, setBottomError, setPassword, readOnly, setClear;
  final bool useLabelWithBorder;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle? style;
  final TextAlignVertical? textAlignVertical;
  final double? radius;
  final Color backgroundColor;
  final Widget? suffix, prefix;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final String Function(String)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final BoxBorder? boxBorder;
  final int maxLine;
  final int minLine;
  final int? maxLength;
  final AutovalidateMode autoValidateMode;

  const TextFormFieldCustom({
    Key? key,
    this.hint,
    this.setPassword = false,
    this.radius,
    this.readOnly = false,
    this.textInputAction = TextInputAction.next,
    this.decoration,
    this.backgroundColor = Colors.white,
    this.style,
    this.textAlignVertical,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.suffix,
    this.setClear = false,
    this.prefix,
    this.setError = false,
    this.setBottomError = false,
    this.onChanged,
    this.onSubmit,
    this.controller,
    this.boxBorder,
    this.onTap,
    this.validator,
    this.maxLength,
    this.minLine = 1,
    this.maxLine = 1,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.useLabelWithBorder = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TextFormFieldCustomState();
}

class TextFormFieldCustomState extends State<TextFormFieldCustom> {
  bool _passwordVisible = false;
  bool isError = false;
  bool isClear = false;
  bool isShowClear = false;
  String errorText = "";
  final GlobalKey _passKey = GlobalKey();
  final _formKey = GlobalKey<EditableTextState>();
  final FocusNode phoneNumberFocusNode = FocusNode();
  AutovalidateMode? _autovalidateMode;

  BoxDecoration getBoxDecoration({Color color = Colors.white, double radius = 0.0, BoxBorder? border}) {
    return BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius)), color: color, border: border);
  }

  OutlineInputBorder outlineFocusedInputBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.008)),
    borderSide: BorderSide(width: deviceHeight * 0.001, color: colorPrimary),
  );
  OutlineInputBorder outlineInputBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.008)),
    borderSide: BorderSide(width: deviceHeight * 0.001, color: colorMainView),
  );

  @override
  Widget build(BuildContext context) {
    InputDecoration? decoration;
    if (widget.useLabelWithBorder) {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
      decoration = InputDecoration(
        border: outlineInputBorderStyle,
        errorBorder: outlineInputBorderStyle,
        focusedBorder: outlineFocusedInputBorderStyle,
        enabledBorder: outlineInputBorderStyle,
        focusedErrorBorder: outlineFocusedInputBorderStyle,
        labelText: widget.decoration?.labelText ?? "",
        hintText: widget.decoration?.hintText ?? "",
        contentPadding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.04, vertical: deviceHeight * 0.010),
        labelStyle: bodyText(textColor: colorLoginTextLight, fontSize: textSizeMediumBig).copyWith(height: deviceHeight * 0.0008),
        hintStyle: bodyText(textColor: colorLoginTextLight, fontSize: textSizeMediumBig).copyWith(height: deviceHeight * 0.0008),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      );
    } else {
      decoration = widget.decoration;
    }

    var eyeButton = GestureDetector(
      child: Container(
        padding: EdgeInsetsDirectional.only(end: deviceWidth * 0.02),
        constraints: const BoxConstraints(),
        child: Icon(
          _passwordVisible ? Icons.visibility_off : Icons.visibility,
          color: colorIconColor,
          size: deviceAverageSize * 0.035,
        ),
      ),
      onTap: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
      },
    );

    var errorButton = Tooltip(
      key: _passKey,
      message: errorText,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsetsDirectional.only(end: deviceWidth * 0.01),
          constraints: const BoxConstraints(),
          child: Icon(
            Icons.error,
            color: Colors.red,
            size: deviceAverageSize * 0.035,
          ),
        ),
        onTap: () async {
          final dynamic tooltip = _passKey.currentState;
          tooltip.ensureTooltipVisible();
          await Future.delayed(const Duration(seconds: 3));
          tooltip.deactivate();
        },
      ),
    );

    var clearButton = IconButton(
      padding: EdgeInsetsDirectional.only(end: deviceWidth * 0.01),
      constraints: const BoxConstraints(),
      icon: Icon(
        Icons.close,
        size: deviceAverageSize * 0.035,
      ),
      onPressed: () {
        isClear = false;
        widget.controller?.text = "";
        SchedulerBinding.instance.addPostFrameCallback((_) {
          setState(() {});
        });
      },
    );

    var e = (isError && widget.setError);

    InputDecoration inputDecoration = InputDecoration(
        border: decoration?.border ?? InputBorder.none,
        counterText: '',
        contentPadding: decoration?.contentPadding ?? EdgeInsets.symmetric(horizontal: deviceWidth * 0.015, vertical: deviceHeight * 0.010),
        labelText: decoration?.labelText,
        floatingLabelBehavior: decoration?.floatingLabelBehavior,
        labelStyle: decoration?.labelStyle,
        errorStyle: (widget.setBottomError) ? null : const TextStyle(height: 0, fontSize: 0.0),
        errorMaxLines: 2,
        focusedBorder: decoration?.focusedBorder,
        enabledBorder: decoration?.enabledBorder,
        errorBorder: decoration?.errorBorder,
        focusedErrorBorder: decoration?.focusedErrorBorder,
        floatingLabelStyle: decoration?.floatingLabelStyle,
        hintStyle: decoration?.hintStyle ?? bodyText(fontSize: textSizeSmall, textColor: colorTextCommonLight),
        hintText: widget.hint ?? decoration?.hintText ?? "",
        // hintTextDirection: TextDirection.ltr,
        isDense: decoration?.isDense ?? false,
        suffixIconConstraints: const BoxConstraints(),
        prefixIconConstraints: const BoxConstraints(),
        isCollapsed: decoration?.isCollapsed ?? true,
        alignLabelWithHint: true,
        prefixIcon: widget.prefix,
        prefix: decoration?.prefix,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (e && !widget.setBottomError) errorButton,
            if (widget.setPassword) eyeButton,
            if (widget.suffix != null) widget.suffix ?? const SizedBox(width: 0, height: 0),
            if (isClear && widget.setClear) clearButton
          ],
        ));

    validate(value) {
      if (widget.validator != null) {
        errorText = widget.validator?.call(value) ?? "";
        isError = errorText.isNotEmpty;

        // print("validate => $isError $errorText");
      }
    }

    return Container(
      decoration: getBoxDecoration(color: widget.backgroundColor, radius: widget.radius ?? 2.0, border: widget.boxBorder),
      // padding: widget.padding ?? textFormFieldPadding,
      child: TextFormField(
          key: _formKey,
          readOnly: widget.readOnly,
          style: widget.style,
          textAlignVertical: widget.textAlignVertical,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          textAlign: widget.textAlign,
          maxLines: widget.maxLine,
          maxLength: widget.maxLength ?? TextField.noMaxLength,
          minLines: widget.minLine,
          obscuringCharacter: "*",
          obscureText: !_passwordVisible && widget.setPassword,
          //This will obscure text dynamically
          inputFormatters: widget.inputFormatters,
          autovalidateMode: widget.setBottomError ? AutovalidateMode.onUserInteraction : _autovalidateMode ?? widget.autoValidateMode,
          validator: (value) {
            validate(value);
            if (!widget.setBottomError) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() {});
              });
            }
            // print("===> $isError || ${widget.setBottomError}  $errorText ");

            return isError
                ? widget.setBottomError
                    ? errorText
                    : ""
                : null;
          },
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
            isClear = value.isNotEmpty;
            validate(value);
            SchedulerBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() {});
            });
          },
          onFieldSubmitted: widget.onSubmit,
          onTap: widget.onTap,
          decoration: inputDecoration),
    );
  }

  @override
  void initState() {
    _passwordVisible = false;
    if (Platform.isIOS && widget.keyboardType == TextInputType.number) {
      phoneNumberFocusNode.addListener(() {
        bool hasFocus = phoneNumberFocusNode.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    phoneNumberFocusNode.dispose();
    super.dispose();
  }
}

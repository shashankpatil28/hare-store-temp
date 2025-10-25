// Path: lib/screen/offerScreen/offer_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/custom_text_field.dart';
import '../../commonView/dropdown_button2.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/widget_util.dart';
import '../../dialog/simple_dialog_box.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import 'offer_bloc.dart';
import 'offer_dl.dart';
import 'offer_shimmer.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<StatefulWidget> createState() => OfferSate();
}

class OfferSate extends State<OfferScreen> {
  OfferBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc = _bloc ?? OfferBloc(context,this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        title: Text(
          languages.navOffer,
          style: toolbarStyle(),
        ),
      ),
      body: StreamBuilder<ApiResponse<OfferResponse>>(
          stream: _bloc!.getOfferSubject,
          builder: (context, snapshot) {
            var formKey = GlobalKey<FormState>();
            if (snapshot.hasData && snapshot.data != null) {
              switch (snapshot.data!.status) {
                case Status.loading:
                  return const OfferShimmer();
                case Status.completed:
                  return Stack(
                    children: [
                      Form(
                        key: formKey,
                        child: Container(
                          width: double.maxFinite,
                          margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.03, end: deviceWidth * 0.03),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: deviceHeight * 0.03),
                              TextFormFieldCustom(
                                textInputAction: TextInputAction.next,
                                controller: _bloc!.minimumBillAmount,
                                setError: true,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    var hasMatch = getTwoDigitRegExp(newValue.text);
                                    if (hasMatch || newValue.text.isEmpty) {
                                      return newValue;
                                    }
                                    return oldValue;
                                  }),
                                ],
                                useLabelWithBorder: true,
                                decoration: InputDecoration(labelText: languages.minimumBillAmount),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return languages.enterAmount;
                                  } else {
                                    double parse = double.parse(value);
                                    if (parse <= 0) {
                                      return languages.enterAmount;
                                    }
                                  }
                                  return "";
                                },
                                prefix: Padding(
                                  padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.04),
                                  child: Text(prefGetStringWithDefaultValue(prefSelectedCurrency, defaultCurrency)),
                                ),
                              ),
                              SizedBox(height: deviceHeight * 0.03),
                              TextFormFieldCustom(
                                textInputAction: TextInputAction.done,
                                controller: _bloc!.discountOffer,
                                setError: true,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                useLabelWithBorder: true,
                                decoration: InputDecoration(labelText: languages.discountOffer),
                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    var hasMatch = getTwoDigitRegExp(newValue.text);

                                    if (hasMatch || newValue.text.isEmpty) {
                                      return newValue;
                                    }
                                    return oldValue;
                                  }),
                                ],
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return languages.enterAmount;
                                  } else {
                                    double parse = double.parse(value);
                                    if (parse <= 0) {
                                      return languages.enterAmount;
                                    }
                                  }
                                  if (_bloc!.offerType!.offerType == 2 && isNumeric(_bloc!.discountOffer.text)) {
                                    var amt = double.parse(_bloc!.discountOffer.text);
                                    if (amt > 100) {
                                      return languages.percentageMessage;
                                    }
                                  }
                                  return "";
                                },
                              ),
                              SizedBox(height: deviceHeight * 0.03),
                              DropdownButtonFormField2(
                                isDense: true,
                                value: _bloc!.offerType,
                                focusColor: Colors.transparent,
                                items: _bloc!.list
                                    .map(
                                      (label) => DropdownMenuItem(
                                        value: label,
                                        child: Text(label.offerName, style: bodyText(fontSize: textSizeSmall)),
                                      ),
                                    )
                                    .toList(),
                                buttonPadding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.025),
                                decoration: getInputDecorationCommon(labelText: languages.offerType),
                                onChanged: (value) {
                                  _bloc?.offerType = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(deviceAverageSize * 0.025),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(deviceAverageSize * 0.015),
                                alignment: Alignment.bottomCenter,
                                child: StreamBuilder<ApiResponse<OfferResponse>>(
                                  stream: _bloc!.getOfferRemove,
                                  builder: (context, snapshot) {
                                    return CustomRoundedButton(
                                      context,
                                      languages.removeOffer,
                                      () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SimpleDialogBox(
                                                title: languages.removeOffer,
                                                positiveClick: () {
                                                  Navigator.pop(context);
                                                  _bloc?.getAndUpdateOffer(isUpdate: true, subject: _bloc!.getOfferRemove, isClearOffer: true);
                                                },
                                                descriptions: languages.removeOfferMsg,
                                                positiveButton: languages.ok,
                                                negativeButton: languages.cancel,
                                              );
                                            },
                                            barrierDismissible: false);
                                      },
                                      // padding: buttonPaddingSmall,
                                      setBorder: true,
                                      textColor: colorTextCommon,
                                      minHeight: commonBtnHeightMedium,
                                      minWidth: buttonMinWidth,
                                      fontWeight: FontWeight.w700,
                                      textSize: textSizeMediumBig,
                                      setProgress: (snapshot.hasData && snapshot.data != null)
                                          ? ((snapshot.data?.status ?? Status.completed) == Status.loading)
                                          : false,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(deviceAverageSize * 0.015),
                                alignment: Alignment.bottomCenter,
                                child: StreamBuilder<ApiResponse<OfferResponse>>(
                                  stream: _bloc!.getOfferUpdate,
                                  builder: (context, snapshot) {
                                    return CustomRoundedButton(
                                      context,
                                      languages.save,
                                      () {
                                        final isValid = formKey.currentState?.validate();
                                        if (isValid ?? false) {
                                          _bloc?.getAndUpdateOffer(isUpdate: true, subject: _bloc!.getOfferUpdate);
                                        }
                                      },
                                      fontWeight: FontWeight.w700,
                                      textSize: textSizeMediumBig,
                                      minWidth: buttonMinWidth,
                                      minHeight: commonBtnHeightMedium,
                                      setProgress: (snapshot.hasData && snapshot.data != null)
                                          ? ((snapshot.data?.status ?? Status.completed) == Status.loading)
                                          : false,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                case Status.error:
                  return Retry(
                    onRetryPressed: () {
                      _bloc?.getAndUpdateOffer(isUpdate: false);
                    },
                  );
              }
            }
            return Container();
          }),
    );
  }
}

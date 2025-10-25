// Path: lib/screen/settingScreen/setting_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/custom_text_field.dart';
import '../../commonView/dropdown_button2.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/widget_util.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import 'setting_bloc.dart';
import 'setting_dl.dart';
import 'setting_shimmer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc = _bloc ?? SettingBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        title: Text(
          languages.navSetting,
          style: toolbarStyle(),
        ),
      ),
      body: StreamBuilder<ApiResponse<SettingModel>>(
          stream: _bloc!.settingSubject,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              switch (snapshot.data!.status) {
                case Status.loading:
                  return const SettingShimmer();
                case Status.completed:
                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.035, end: deviceWidth * 0.035, top: deviceHeight * 0.025),
                              child: DropdownButtonFormField2(
                                isDense: true,
                                value: _bloc!.deliveryTime,
                                items: _bloc!.edtList
                                    .map(
                                      (label) => DropdownMenuItem(value: label, child: Text(label.key, style: bodyText())),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  _bloc?.deliveryTime = value;
                                },
                                decoration: getInputDecorationCommon(labelText: languages.estimatedDeliveryTime),
                              ),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.035, end: deviceWidth * 0.035, top: deviceHeight * 0.025),
                              child: DropdownButtonFormField2(
                                value: _bloc!.storeDeliveryRadius,
                                isDense: true,
                                items: _bloc!.radiusList.map((label) => DropdownMenuItem(value: label, child: Text(label.key, style: bodyText()))).toList(),
                                onChanged: (value) {
                                  _bloc?.storeDeliveryRadius = value;
                                },
                                decoration: getInputDecorationCommon(labelText: languages.storeDeliveryRadius),
                              ),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.035, end: deviceWidth * 0.035, top: deviceHeight * 0.025),
                              child: TextFormFieldCustom(
                                textInputAction: TextInputAction.next,
                                controller: _bloc!.orderMinAmount,
                                setError: true,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                useLabelWithBorder: true,
                                decoration: InputDecoration(labelText: languages.orderMinAmount),
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
                                  }

                                  return "";
                                },
                                prefix: Padding(
                                  padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.035, end: deviceWidth * 0.01),
                                  child: Text(
                                    prefGetStringWithDefaultValue(prefSelectedCurrency, defaultCurrency),
                                    style: bodyText(textColor: colorTextCommonLight),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.035, end: deviceWidth * 0.035, top: deviceHeight * 0.025),
                              child: TextFormFieldCustom(
                                textInputAction: TextInputAction.next,
                                controller: _bloc!.packageCharge,
                                setError: true,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                useLabelWithBorder: true,
                                decoration: InputDecoration(labelText: languages.packagingCharge),
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
                                  }
                                  return "";
                                },
                                prefix: Padding(
                                  padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.035, end: deviceWidth * 0.01),
                                  child: Text(
                                    prefGetStringWithDefaultValue(prefSelectedCurrency, defaultCurrency),
                                    style: bodyText(textColor: colorTextCommonLight),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.035, vertical: deviceHeight * 0.015),
                              child: Text(
                                languages.storeTiming,
                                style: bodyText(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(deviceAverageSize * 0.007),
                              ),
                              margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.007, horizontal: deviceWidth * 0.035),
                              padding: EdgeInsets.all(deviceAverageSize * 0.008),
                              child: Column(
                                children: [
                                  Table(
                                    border: TableBorder(
                                        bottom: BorderSide(width: 1, color: textColorWithOpacity, style: BorderStyle.solid),
                                        verticalInside: BorderSide(width: 1, color: textColorWithOpacity, style: BorderStyle.solid)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.016),
                                          child: Text(
                                            languages.day,
                                            style: bodyText(),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.016),
                                          child: Text(
                                            languages.openingTime,
                                            style: bodyText(),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.016),
                                          child: Text(
                                            languages.closingTime,
                                            textAlign: TextAlign.right,
                                            style: bodyText(),
                                          ),
                                        )
                                      ])
                                    ],
                                  ),
                                  StreamBuilder<List<StoreTimings>>(
                                      stream: _bloc!.storeTimingSubject,
                                      builder: (context, snapshot) {
                                        var data = snapshot.data;
                                        if (data != null) {
                                          return Table(
                                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                            border: TableBorder(verticalInside: BorderSide(width: 1, color: textColorWithOpacity, style: BorderStyle.solid)),
                                            children: getProductList(context, data, _bloc!),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                ],
                              ),
                            ),
                            StreamBuilder<ApiResponse>(
                                stream: _bloc!.updateSubject,
                                builder: (context, snapshot) {
                                  return CustomRoundedButton(
                                    context,
                                    languages.save,
                                    () {
                                      final isValid = formKey.currentState!.validate();
                                      if (isValid) {
                                        _bloc?.getAndUpdateSetting(isUpdate: true);
                                      }
                                    },
                                    minHeight: commonBtnHeight,
                                    fontWeight: FontWeight.w700,
                                    textSize: textSizeLarge,
                                    margin: EdgeInsetsDirectional.only(
                                      start: deviceWidth * 0.035,
                                      end: deviceWidth * 0.035,
                                      bottom: deviceHeight * 0.03,
                                      top: deviceHeight * 0.02,
                                    ),
                                    minWidth: double.infinity,
                                    setProgress: snapshot.data?.status == Status.loading,
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  );
                case Status.error:
                  return Error(
                    errorMessage: snapshot.data?.message ?? "",
                    onRetryPressed: () {},
                  );
              }
            }
            return Container();
          }),
    );
  }

  getProductList(BuildContext context, List<StoreTimings> list, SettingBloc bloc) {
    return list // Loops through dataColumnText, each iteration assigning the value to element
        .map(
      ((element) {
        var index = list.indexOf(element);
        return TableRow(
          children: [
            GestureDetector(
              onTap: () {
                bool value = !element.isCheck;
                list[index].isCheck = value;
                bloc.storeTimingSubject.add(list);
              },
              child: Row(
                children: [
                  Checkbox(
                    value: element.isCheck,
                    onChanged: (value) {
                      element.isCheck = value ?? false;
                      list[index].isCheck = value ?? false;
                      bloc.storeTimingSubject.add(list);
                    },
                  ),
                  Expanded(
                      child: Text(
                    element.displayDay,
                    style: bodyText(fontWeight: FontWeight.w500),
                  ))
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (element.isCheck) {
                  var parse = getDateTimeObjWithoutTimezone(element.openTime, format: 'hh:mm a', returnFormat: 'HH:mm');
                  bloc.selectTime(
                    context,
                    (time) {
                      var format = getDateTimeWithoutTimezone("${time.hour}:${time.minute}", format: 'HH:mm', returnFormat: 'hh:mm a');
                      list[index].openTime = format;
                      list[index].closeTime = "";
                      bloc.storeTimingSubject.add(list);
                    },
                    hour: parse.hour,
                    minute: parse.minute,
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    //I changed this format because this format is not working in (zh,ja,ko,mn etc...)
                    Text(
                      element.isCheck ? getTimeFormat(element.openTime, format: "hh:mm aa") : "--:--",
                      style: bodyText(fontWeight: FontWeight.w600, fontSize: textSizeSmall),
                    ),
                    Divider(
                      height: deviceHeight * 0.003,
                      color: colorMainView,
                      indent: 20,
                      thickness: 1,
                      endIndent: 20,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (element.isCheck) {
                  var parse = DateTime.now();
                  if (element.closeTime.trim().isNotEmpty) {
                    parse = getDateTimeObjWithoutTimezone(element.closeTime, format: 'hh:mm a', returnFormat: 'HH:mm');
                  }

                  bloc.selectTime(
                    context,
                    (time) {
                      var format = getDateTimeWithoutTimezone("${time.hour}:${time.minute}", format: 'HH:mm', returnFormat: 'hh:mm a');
                      if (compareTimesForSettings(element.openTime, format)) {
                        list[index].closeTime = format;
                        bloc.storeTimingSubject.add(list);
                      } else {
                        openSimpleSnackbar(languages.invalidDateSelection);
                      }
                    },
                    hour: parse.hour,
                    minute: parse.minute,
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    //I changed this format because this format is not working in (zh,ja,ko,mn etc...)
                    Text(
                      (element.isCheck ? (element.closeTime.trim().isNotEmpty ? getTimeFormat(element.closeTime, format: "hh:mm aa") : "--:--") : "--:--"),
                      style: bodyText(fontWeight: FontWeight.w600, fontSize: textSizeSmall),
                    ),
                    Divider(
                      height: deviceHeight * 0.003,
                      color: colorMainView,
                      indent: 20,
                      thickness: 1,
                      endIndent: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    ).toList();
  }
}

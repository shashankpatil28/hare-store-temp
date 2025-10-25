// Path: lib/screen/selectLanguageAndCurrency/language_currency_screen.dart

import 'package:flutter/material.dart';

import '../../commonView/my_widgets.dart';
import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/common_util.dart';
import 'item_currency.dart';
import 'item_language.dart';
import 'language_currency_bloc.dart';
import 'language_currency_dl.dart';
import 'select_language_and_currency_shimmer.dart';

class LanguageCurrencyScreen extends StatefulWidget {
  final bool isFromHome;

  const LanguageCurrencyScreen({super.key, this.isFromHome = false});

  @override
  LanguageCurrencyScreenState createState() => LanguageCurrencyScreenState();
}

class LanguageCurrencyScreenState extends State<LanguageCurrencyScreen> {
  late LanguageCurrencyBloc _preferenceBloc;

  @override
  void dispose() {
    _preferenceBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _preferenceBloc = LanguageCurrencyBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: !widget.isFromHome,
          title: Text(
            languages.preferences.toUpperCase(),
            style: toolbarStyle(),
          ),
        ),
        body: _buildLanguageAndCurrency(context));
  }

  _buildLanguageAndCurrency(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(
              top: deviceHeight * 0.025,
              start: deviceWidth * 0.035,
              end: deviceWidth * 0.035),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                languages.selectLanguage,
                style: bodyText(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: deviceHeight * 0.01),
              ItemLanguage(
                languageList: _preferenceBloc.spLanguage,
                defaultSelected: _preferenceBloc.spLanguage.indexWhere(
                    (element) =>
                        element.languageCode ==
                        prefGetString(prefSelectedLanguageCode)),
                onSelectionChanged: (value) {
                  _preferenceBloc.setSelectedLanguage(value);
                },
              ),
              SizedBox(height: deviceHeight * 0.03),
              Text(
                languages.selectCurrency,
                style: bodyText(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: deviceHeight * 0.01),
              StreamBuilder<ApiResponse<CurrencyData>>(
                  stream: _preferenceBloc.languageAndCurrencySubject,
                  builder: (context, snapCurrency) {
                    var isLoading = snapCurrency.hasData &&
                        snapCurrency.data?.status == Status.loading;
                    List<CurrencyList> currencyList =
                        snapCurrency.data?.data?.currencyList ?? [];
                    CurrencyList currencyListItem = currencyList.firstWhere(
                        (element) =>
                            element.currencySymbol ==
                            prefGetStringWithDefaultValue(
                                prefSelectedCurrency, defaultCurrency),
                        orElse: () {
                      return CurrencyList();
                    });
                    Widget simmerView = SelectLanguageAndCurrencyShimmer(
                      enabled: isLoading,
                    );
                    return isLoading
                        ? simmerView
                        : ItemCurrency(
                            currencyList: currencyList,
                            defaultSelected: currencyListItem.currencyId ?? 0,
                            onSelectionChanged: (value) {
                              _preferenceBloc.setSelectedCurrency(value);
                            },
                          );
                  }),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!widget.isFromHome)
                Text(
                  languages.preferenceMsg,
                  style: bodyText(fontSize: textSizeSmall),
                ),
              updateButton(_preferenceBloc),
            ],
          ),
        ),
      ],
    );
  }

  updateButton(LanguageCurrencyBloc bloc) => StreamBuilder(
        stream: bloc.streamSelectedCurrency,
        builder: (context, selectedItemSnapshot) {
          return StreamBuilder<ApiResponse<BaseModel>>(
            stream: _preferenceBloc.updateSubject.stream,
            builder: (context, snap) {
              var isLoading =
                  snap.hasData && snap.data?.status == Status.loading;
              return CustomRoundedButton(
                context,
                widget.isFromHome ? languages.update : languages.next,
                (!selectedItemSnapshot.hasData || isLoading)
                    ? () {}
                    : () {
                        bloc.submit(context, widget.isFromHome);
                      },
                setProgress: isLoading,
                fontWeight: FontWeight.bold,
                textSize: textSizeLarge,
                minWidth: deviceWidth,
                minHeight: commonBtnHeight,
                margin: EdgeInsetsDirectional.only(
                  start: deviceWidth * 0.035,
                  end: deviceWidth * 0.035,
                  bottom: deviceHeight * 0.03,
                  top: deviceHeight * 0.02,
                ),
              );
            },
          );
        },
      );
}

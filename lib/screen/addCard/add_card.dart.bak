// Path: lib/screen/addCard/add_card.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonView/custom_text_field.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/common_util.dart';
import '../../utils/custom_icons.dart';
import '../../utils/payment_card.dart';
import 'add_card_bloc.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<StatefulWidget> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  late AddCardBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = AddCardBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: false,
          titleSpacing: 0,
          title: Text(
            languages.addCard,
            style: toolbarStyle(),
          ),
        ),
        body: _buildAddCard(context),
      );

  _buildAddCard(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.08),
          child: Container(
            margin: EdgeInsetsDirectional.only(
                start: deviceWidth * 0.04, top: deviceHeight * 0.025, bottom: deviceHeight * 0.01, end: deviceWidth * 0.04),
            child: Form(
              key: _bloc.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languages.safeAndSecurePaymentMethod,
                    maxLines: 1,
                    style: bodyText(fontWeight: FontWeight.w600, fontSize: textSizeBig),
                  ),
                  SizedBox(height: deviceHeight * 0.015),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.01)),
                          child: Image.asset(
                            "assets/images/payment_visa.png",
                            width: deviceWidth * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.04),
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.01)),
                          child: Image.asset(
                            "assets/images/payment_master_card.png",
                            width: deviceWidth * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.04),
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.01)),
                          child: Image.asset(
                            "assets/images/payment_amex.png",
                            width: deviceWidth * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.04),
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.01)),
                          child: Image.asset(
                            "assets/images/payment_discover_network.png",
                            width: deviceWidth * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: deviceHeight * 0.045),
                  Text(
                    languages.addCardDetails,
                    maxLines: 1,
                    style: bodyText(fontSize: textSizeBig, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.02),
                    child: cardHolderNameField(),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.03),
                    child: cardNumberField(),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.03),
                    child: expirationDateField(),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.03),
                    child: cvvField(),
                  ),
                  if (isDemoApp)
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      padding: EdgeInsetsDirectional.only(
                          start: deviceWidth * 0.02, end: deviceWidth * 0.02, top: deviceHeight * 0.009, bottom: deviceHeight * 0.009),
                      margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.002, bottom: deviceHeight * 0.012),
                      child: Text(
                        languages.dummyCardNote,
                        textAlign: TextAlign.start,
                        style: bodyText(fontSize: textSizeRegular, textColor: colorTextCommon, fontWeight: FontWeight.normal),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: addCardButton(),
        ),
      ],
    );
  }

  cardHolderNameField() => TextFormFieldCustom(
        controller: _bloc.cardHolderNameTEC,
        decoration: InputDecoration(labelText: languages.hintCardHolderName),
        useLabelWithBorder: true,
        suffix: Padding(
          padding: EdgeInsetsDirectional.only(end: deviceWidth * 0.04),
          child: Icon(
            CustomIcons.myProfileDrawerIc,
            size: deviceHeight * 0.02,
            color: colorMainLightGray,
          ),
        ),
        style: bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600),
        setError: true,
        validator: (value) {
          return validateEmptyField(value, languages.enterHolderName);
        },
      );

  cardNumberField() => StreamBuilder<CardType>(
        stream: _bloc.cardType,
        builder: (context, snap) {
          return TextFormFieldCustom(
            // controller: _bloc.cardNumberTEC,
            onChanged: _bloc.changeCardNumber,
            keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
            useLabelWithBorder: true,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(19), CardNumberInputFormatter()],
            decoration: InputDecoration(labelText: languages.hintYourCardNumber),
            suffix: Padding(
              padding: EdgeInsetsDirectional.only(end: deviceWidth * 0.04),
              child: snap.hasData
                  ? CardUtils.getCardIcon(snap.data!)
                  : Icon(
                      CustomIcons.card,
                      size: deviceHeight * 0.025,
                      color: colorMainLightGray,
                    ),
            ),
            style: bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600),
            setError: true,
            validator: (value) {
              return validateCardNumber(value);
            },
          );
        },
      );

  expirationDateField() => TextFormFieldCustom(
        controller: _bloc.expiredDateTEC,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6), CardMonthInputFormatter()],
        useLabelWithBorder: true,
        decoration: InputDecoration(labelText: languages.hintExpirationDate, hintText: languages.cardDateFormat),
        suffix: Padding(
          padding: EdgeInsetsDirectional.only(end: deviceWidth * 0.04),
          child: Icon(
            CustomIcons.calendarAddCard,
            size: deviceHeight * 0.02,
            color: colorMainLightGray,
          ),
        ),
        style: bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600),
        setError: true,
        validator: (value) {
          return validateExpirationDate(value);
        },
      );

  cvvField() => TextFormFieldCustom(
        controller: _bloc.cvvTEC,
        keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
        textInputAction: TextInputAction.done,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('^[0-9]*\$')),
        ],
        setPassword: true,
        maxLength: 3,
        useLabelWithBorder: true,
        decoration: InputDecoration(labelText: languages.hintCvv),
        style: bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600),
        setError: true,
        validator: (value) {
          return validateWithFixLength(value, 3, languages.enterCvv, languages.invalidCvv);
        },
      );

  addCardButton() => /*StreamBuilder<bool>(
        stream: _bloc.submitValid,
        builder: (context, snap) {
          return */
      StreamBuilder<ApiResponse<BaseModel>>(
        stream: _bloc.subject,
        builder: (context, snapLoading) {
          var isLoading = snapLoading.hasData && snapLoading.data?.status == Status.loading;
          return CustomRoundedButton(
            context,
            languages.buttonAddCard,
            () {
              _bloc.addCard();
            },
            setProgress: isLoading,
            fontWeight: FontWeight.w700,
            textSize: textSizeLarge,
            minWidth: deviceWidth,
            bgColor: colorPrimary,
            textColor: colorWhite,
            minHeight: commonBtnHeight,
            padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.18, end: deviceWidth * 0.18),
            margin: EdgeInsetsDirectional.only(
              start: deviceWidth * 0.05,
              end: deviceWidth * 0.05,
              top: deviceHeight * 0.05,
              bottom: deviceHeight * 0.035,
            ),
          );
        },
      );
/* },
      );*/
}

// Path: lib/dialog/rejectDialog/reject_order_dialog.dart

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../commonView/custom_text_field.dart';
import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../screen/homeScreen/home_dl.dart';
import '../../utils/common_util.dart';
import '../simple_dialog_box.dart';
import 'reject_order_bloc.dart';

class RejectOrderDialog extends StatefulWidget {
  final Function(String ordersItems, BehaviorSubject<ApiResponse<HomeResponse>> subject) _setAction;

  const RejectOrderDialog(this._setAction, {super.key});

  @override
  DialogsState createState() => DialogsState();
}

class DialogsState extends State<RejectOrderDialog> {
  RejectOrderBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc = _bloc ?? RejectOrderBloc(context);
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
    var reason = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<ApiResponse<HomeResponse>>(
          stream: _bloc!.rejectOrder,
          builder: (context, snapshot) {
            ApiResponse? data = snapshot.data;
            // var object = data?.status ?? Status.COMPLETED;
            if (data != null && data.status == Status.completed) {
              Navigator.pop(context);
            }
            return SimpleDialogBox(
              progress: data?.status == Status.loading,
              title: languages.rejectOrder,
              widget: Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
                  child: TextFormFieldCustom(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    controller: reason,
                    minLine: 1,
                    maxLine: 3,
                    setError: true,
                    validator: (value) {
                      return validateEmptyField(value, languages.enterRejectReason);
                    },
                    useLabelWithBorder: true,
                    decoration: InputDecoration(
                      labelText: languages.enterRejectReason,
                      isDense: true,
                      contentPadding: EdgeInsetsDirectional.only(
                          start: deviceWidth * 0.02, end: deviceWidth * 0.02, top: deviceHeight * 0.005, bottom: deviceHeight * 0.005),
                    ),
                  ),
                ),
              ),
              positiveClick: () {
                if (formKey.currentState!.validate()) {
                  widget._setAction(reason.text, _bloc!.rejectOrder);
                }
              },
              color: colorPrimary,
              descriptions: languages.rejectOrderMessage,
              positiveButton: languages.ok,
              negativeButton: languages.cancel,
            );
          }),
    );
  }
}

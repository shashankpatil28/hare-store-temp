// Path: lib/screen/pendingScreen/pending_screen.dart

import 'package:flutter/material.dart';

import '../../commonView/my_widgets.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import '../loginScreen/login_screen.dart';
import 'pending_bloc.dart';

class PendingScreen extends StatefulWidget {
  final String data;
  final Widget? widget;

  const PendingScreen({super.key, this.data = "", this.widget});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  PendingBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc = _bloc ?? PendingBloc(context,this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var blockMain = PendingBloc(context,this);
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: deviceWidth * 0.02,
          title: Text(
            languages.appName,
            style: toolbarStyle(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  color: colorPrimary,
                  size: deviceAverageSize * 0.2,
                ),
                if (widget.widget != null)
                  Container(margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.007, horizontal: deviceWidth * 0.03), child: widget.widget),
                if (widget.data.isNotEmpty)
                  Container(
                      margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.04, horizontal: deviceWidth * 0.012),
                      child: Text(
                        widget.data,
                        textAlign: TextAlign.center,
                        style: bodyText(fontSize: textSizeBig),
                      )),
              ],
            )),
            StreamBuilder<ApiResponse>(
                stream: blockMain.logoutSubject,
                builder: (context, snapshot) {
                  return CustomRoundedButton(context, languages.logout, () {
                    blockMain.logoutCall(context);
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
                      setProgress: snapshot.data?.status == Status.loading);
                }),
          ],
        ),
      ),
      onWillPop: () async {
        if (!Navigator.canPop(context)) {
          openScreenWithClearPrevious(context, const LoginScreen());
          return false;
        }
        return true;
      },
    );
  }
}

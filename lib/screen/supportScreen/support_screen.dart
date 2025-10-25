// Path: lib/screen/supportScreen/support_screen.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../commonView/no_record_found.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import 'support_bloc.dart';
import 'support_detail_page.dart';
import 'support_dl.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<StatefulWidget> createState() => SupportScreenState();
}

class SupportScreenState extends State<SupportScreen> {
  SupportBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc = _bloc ?? SupportBloc(context,this);
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
      appBar: AppBar(
          title: Text(
        languages.navSupport,
        style: toolbarStyle(),
      )),
      body: StreamBuilder<ApiResponse<List<Pages>>>(
          // --- FIX: Use correct stream name ---
          stream: _bloc!.getSupportPagesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              switch (snapshot.data!.status) {
                case Status.loading:
                  return Shimmer.fromColors(
                    baseColor: colorShimmerBg,
                    highlightColor: highlightColor,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: deviceHeight * 0.0025,
                          color: Colors.black,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Container(color: Colors.black, height: deviceHeight * 0.03, margin: EdgeInsets.all(deviceAverageSize * 0.02));
                      },
                      itemCount: 15,
                    ),
                  );
                case Status.completed:
                  List<Pages> list = snapshot.data?.data ?? [];
                  return ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                      color: colorMainView,
                      thickness: deviceHeight * 0.001,
                      height: 0,
                    ),
                    padding: const EdgeInsetsDirectional.only(top: 0),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, position) {
                      return ListTile(
                        onTap: () {
                          openScreen(context, SupportDetailPage(title: list[position].pageName ?? "", pageDetail: list[position].description ?? ""));
                        },
                        horizontalTitleGap: 0,
                        visualDensity: VisualDensity(horizontal: deviceHeight * 0.003, vertical: deviceHeight * 0.001),
                        title: Text(
                          list[position].pageName ?? "",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: bodyText(fontSize: textSizeLarge, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  );
                case Status.error:
                  return NoRecordFound(message: snapshot.data?.message ?? "");
              }
            }
            return NoRecordFound(message: languages.emptyData);
          }),
    );
  }
}

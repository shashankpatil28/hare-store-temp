// Path: lib/screen/walletTransfer/search_user.dart

import 'package:flutter/material.dart';

import '../../commonView/custom_text_field.dart';
import '../../commonView/load_image_with_placeholder.dart';
import '../../commonView/no_record_found.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import 'search_user_shimmer.dart';
import 'wallet_transfer_bloc.dart';
import 'wallet_transfer_dl.dart';

class SearchUser extends StatefulWidget {
  final WalletTransferBloc bloc;

  const SearchUser({Key? key, required this.bloc}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          automaticallyImplyLeading: true,
          title: Hero(
            tag: "search",
            child: Text(
              languages.searchByContactOrEmail,
              style: toolbarStyle(),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(deviceAverageSize * 0.02)),
                border: Border.all(color: colorMainView, width: deviceAverageSize * 0.002),
                color: colorWhite,
              ),
              padding: EdgeInsets.all(deviceAverageSize * 0.015),
              margin: EdgeInsetsDirectional.only(
                start: deviceWidth * 0.03,
                end: deviceWidth * 0.03,
                bottom: deviceHeight * 0.012,
                top: deviceHeight * 0.012,
              ),
              child: Row(children: [
                const Icon(Icons.search_sharp, color: colorMainLightGray),
                Expanded(
                  child: TextFormFieldCustom(
                    hint: languages.search,
                    textInputAction: TextInputAction.search,
                    controller: widget.bloc.textEditingController,
                    radius: deviceAverageSize * 0.015,
                    validator: (value) {
                      return "";
                    },
                    onSubmit: (search) {
                      if (search.isNotEmpty) {
                        widget.bloc.searchUsers(search);
                      }
                    },
                    setClear: true,
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.015),
                child: StreamBuilder<ApiResponse<UserSearchModel>?>(
                    stream: widget.bloc.searchUser,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        switch (snapshot.data!.status) {
                          case Status.loading:
                            return const SearchUserShimmer();
                          case Status.completed:
                            UserSearchModel? data = snapshot.data?.data;
                            List<TransferUserList> transferUserList = data?.transferUserList ?? [];
                            return transferUserList.isNotEmpty
                                ? ListView.separated(
                                    itemBuilder: (context, index) {
                                      TransferUserList transferUser = transferUserList[index];
                                      String defaultAvatar = "assets/images/avatar_user.png";
                                      if (transferUser.walletProviderType == 0) {
                                        defaultAvatar = "assets/images/avatar_user.png";
                                      } else if (transferUser.walletProviderType == 1) {
                                        defaultAvatar = "assets/images/avatar_store.png";
                                      } else if (transferUser.walletProviderType == 2) {
                                        defaultAvatar = "assets/images/avatar_driver.png";
                                      } else if (transferUser.walletProviderType == 3) {
                                        defaultAvatar = "assets/images/avatar_provider.png";
                                      }

                                      String contactNumber = "${transferUser.countryCode} ${transferUser.contactNumber}";

                                      return InkWell(
                                        onTap: () {
                                          widget.bloc.transferUserList = transferUser;
                                          widget.bloc.textBeneficialController.text = transferUser.name;
                                          widget.bloc.textNumberController.text = contactNumber;
                                          widget.bloc.textEmailController.text = transferUser.email;
                                          Navigator.pop(context, transferUser);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.015, vertical: deviceHeight * 0.001),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              LoadImageWithPlaceHolder(
                                                width: deviceAverageSize * 0.09,
                                                height: deviceAverageSize * 0.09,
                                                image: transferUser.profileImage,
                                                borderRadius: BorderRadius.circular(deviceAverageSize * 0.07),
                                                defaultAssetImage: defaultAvatar,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: deviceHeight * 0.015),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        transferUser.name,
                                                        style: bodyText(fontSize: textSizeMediumBig, fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(contactNumber, style: bodyText()),
                                                      Text(transferUser.email, style: bodyText()),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: transferUserList.length,
                                    separatorBuilder: (BuildContext context, int index) {
                                      return Divider(
                                        indent: deviceAverageSize * 0.11,
                                        endIndent: deviceAverageSize * 0.015,
                                        thickness: 2,
                                      );
                                    },
                                  )
                                : NoRecordFound(message: languages.emptyData);
                          case Status.error:
                            return NoRecordFound(message: snapshot.data?.message ?? "");
                          default:
                            return Container();
                        }
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
                        child: Center(
                          child: Text(
                            languages.enterContactOrEmailToSearchPerson,
                            textAlign: TextAlign.center,
                            style: bodyText(fontSize: textSizeBig, textColor: colorBlack, fontWeight: FontWeight.normal),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}

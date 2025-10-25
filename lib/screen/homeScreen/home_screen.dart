// Path: lib/screen/homeScreen/home_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../commonView/load_image_with_placeholder.dart';
import '../../utils/common_util.dart';
import '../../utils/custom_icons.dart';
import '../bankDetailScreen/bank_detail_screen.dart';
import '../changePasswordScreen/change_password_screen.dart';
import '../liveChatScreen/chatHistory/chat_history_screen.dart';
import '../liveChatScreen/chating/chatting_screen.dart';
import '../loginScreen/login_dl.dart';
import '../manageCard/manage_card.dart';
import '../myProfileScreen/my_profile_screen.dart';
import '../offerScreen/offer_screen.dart';
import '../ordersHistoryScreen/order_history_screen.dart';
import '../productsScreen/product_screen.dart';
import '../selectLanguageAndCurrency/language_currency_screen.dart';
import '../settingScreen/setting_screen.dart';
import '../supportScreen/support_screen.dart';
import '../wallet/wallet.dart';
import 'home_bloc.dart';
import 'home_dl.dart';
import 'orders/dispatchOrder/dispatch_orders.dart';
import 'orders/newOrder/new_orders.dart';
import 'orders/processingOrder/processing_orders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String tag = "HomeScreen>>>";
  HomeBloc? bloc;
  var width = deviceWidth / 3;
  bool isOneTimeClick = true;
  DateTime? currentTime;

  @override
  void didChangeDependencies() {
    bloc = bloc ?? HomeBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tabStyle =
        bodyText(textColor: colorTextCommon, fontWeight: FontWeight.w600);
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentTime == null ||
            now.difference(currentTime!) > const Duration(seconds: 2)) {
          currentTime = now;
          openSimpleSnackbar(languages.appExitMessage);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: colorWhite,
              bottom: TabBar(
                labelPadding: EdgeInsets.zero,
                isScrollable: true,
                labelColor: colorTextCommon,
                indicatorColor: colorPrimary,
                tabs: [
                  Container(
                      constraints: BoxConstraints(minWidth: width),
                      margin:
                          EdgeInsets.symmetric(vertical: deviceHeight * 0.012),
                      width: width,
                      child: Text(languages.newOrder,
                          style: tabStyle, textAlign: TextAlign.center)),
                  // Container(
                  //     constraints: BoxConstraints(minWidth: width),
                  //     margin:
                  //         EdgeInsets.symmetric(vertical: deviceHeight * 0.012),
                  //     child: Text(languages.acceptOrder,
                  //         style: tabStyle, textAlign: TextAlign.center)),
                  Container(
                      constraints: BoxConstraints(minWidth: width),
                      margin:
                          EdgeInsets.symmetric(vertical: deviceHeight * 0.012),
                      child: Text(languages.processingOrder,
                          style: tabStyle, textAlign: TextAlign.center)),
                  Container(
                      constraints: BoxConstraints(minWidth: width),
                      margin:
                          EdgeInsets.symmetric(vertical: deviceHeight * 0.012),
                      child: Text(languages.dispatchOrder,
                          style: tabStyle, textAlign: TextAlign.center)),
                ],
              ),
              title: Text(
                languages.liveOrders,
                style: toolbarStyle(),
              ),
            ),
            body: TabBarView(
              children: [
                NewOrders(bloc!.blocNewOrder!),
                // AcceptedOrders(bloc!.blocAcceptOrder),
                ProcessingOrders(bloc!.blocProcessingOrder),
                DispatchOrders(bloc!.blocDispatchOrder),
              ],
            ),
            onDrawerChanged: (isOpened) {
              if (isOpened) {
                LoginPojo authentication = LoginPojo(
                  providerProfileImage: prefGetString(prefProfileImage),
                  storeProviderName: prefGetString(prefFullName),
                );
                bloc?.authSubject.add(authentication);
              }
            },
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: colorMainDrawer,
                    padding: EdgeInsetsDirectional.only(
                      top: statusHeight + (deviceAverageSize * 0.06),
                      bottom: deviceAverageSize * 0.04,
                      start: deviceAverageSize * 0.04,
                      end: deviceAverageSize * 0.04,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: drawerDriverImage(),
                        ),
                        Flexible(
                          child: drawerDriverName(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: listItem(),
                    ),
                  ),
                  Container(
                    width: deviceWidth,
                    color: colorMainDrawer,
                    padding: EdgeInsetsDirectional.only(
                        top: deviceHeight * 0.012,
                        bottom: deviceHeight * 0.012),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isDemoApp)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/svgs/wlf_icon.svg",
                                    width: deviceWidth * 0.08),
                                SizedBox(width: deviceWidth * 0.02),
                                SvgPicture.asset("assets/svgs/wlf_text.svg",
                                    width: deviceWidth * 0.35),
                              ],
                            ),
                          if (!kIsWeb)
                            FutureBuilder(
                              future: PackageInfo.fromPlatform(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<PackageInfo> snapshot) {
                                return Text(
                                  (snapshot.data != null &&
                                          snapshot.data?.version != null)
                                      ? "Version ${snapshot.data?.version}"
                                      : "",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: bodyText(
                                      textColor: colorBlack,
                                      fontSize: textSizeSmallest),
                                );
                              },
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget drawerDriverImage() {
    return StreamBuilder<LoginPojo>(
      stream: bloc!.authSubject,
      builder: (context, snapshot) {
        String profile = "";

        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.active) {
          profile = snapshot.data!.providerProfileImage;
        }

        return LoadImageWithPlaceHolder(
          width: deviceAverageSize * 0.12,
          height: deviceAverageSize * 0.12,
          image: profile,
          errorImage: "assets/images/avatar_store.png",
          borderRadius: BorderRadius.circular(deviceAverageSize * 0.1),
          defaultAssetImage: 'assets/images/avatar_store.png',
        );
      },
    );
  }

  Widget drawerDriverName() {
    return StreamBuilder<LoginPojo>(
      stream: bloc!.authSubject,
      builder: (context, snapshot) {
        var name = snapshot.data?.storeProviderName ?? "";
        logd(tag, "name=> $name");
        return Container(
          margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: bodyText(
                    fontSize: textSizeLargest,
                    fontWeight: FontWeight.bold,
                    textColor: colorPrimary),
              ),
              Text(
                languages.storeOwner,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: bodyText(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listItem() {
    var list = getList();
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        itemBuilder: (BuildContext context, position) {
          return ListTile(
            dense: true,
            horizontalTitleGap: 0,
            visualDensity:
                VisualDensity(horizontal: 0, vertical: deviceHeight * 0.001),
            onTap: () {
              var drawerEnum = list[position].drawerEnum;

              Navigator.pop(context);
              if (drawerEnum == DrawerEnum.product) {
                navigationPage(context, const ProductScreen());
              } else if (drawerEnum == DrawerEnum.wallet) {
                navigationPage(context, const Wallet());
              } else if (drawerEnum == DrawerEnum.manageCard) {
                navigationPage(context, const ManageCard());
              } else if (drawerEnum == DrawerEnum.orderHistory) {
                navigationPage(context, const OrderHistoryScreen());
              } else if (drawerEnum == DrawerEnum.bankDetail) {
                navigationPage(context, const BankDetailScreen());
              } else if (drawerEnum == DrawerEnum.myProfile) {
                navigationPage(context, const MyProfileScreen());
              } else if (drawerEnum == DrawerEnum.changePassword) {
                navigationPage(context, const ChangePasswordScreen());
              } else if (drawerEnum == DrawerEnum.preference) {
                navigationPage(
                    context,
                    const LanguageCurrencyScreen(
                      isFromHome: true,
                    )).then((value) {
                  bloc?.setHomeDetails();
                });
              } else if (drawerEnum == DrawerEnum.chatWithAdmin) {
                navigationPage(
                    context,
                    ChattingScreen(
                        chatWithId: "a_1",
                        chatWithName: languages.admin,
                        chatWithImage: "",
                        chatWithServicesName: ""));
              } else if (drawerEnum == DrawerEnum.support) {
                navigationPage(context, const SupportScreen());
              } else if (drawerEnum == DrawerEnum.offer) {
                navigationPage(context, const OfferScreen());
              } else if (drawerEnum == DrawerEnum.setting) {
                navigationPage(context, const SettingScreen());
              } else if (drawerEnum == DrawerEnum.liveChat) {
                navigationPage(context, const ChatHistoryScreen());
              } else if (drawerEnum == DrawerEnum.logout) {
                bloc?.openLogoutDialog();
              } else if (drawerEnum == DrawerEnum.selectStore) {
                bloc?.openSelectStoreDialog();
              }
            },
            title: Text(
              list[position].name,
              textAlign: TextAlign.start,
              style: bodyText(
                  fontSize: textSizeBig,
                  fontWeight: FontWeight.w600,
                  textColor: colorTextCommon),
            ),
            leading: list[position].icon,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: colorDivider,
            height: deviceHeight * 0.0004,
            thickness: deviceHeight * 0.001,
          );
        },
        itemCount: list.length);
  }

  List<DrawerItem> getList() {
    double iconSize = deviceAverageSize * 0.045;
    Color iconColor = colorPrimary;
    List<DrawerItem> menus = [
      DrawerItem(
          DrawerEnum.myProfile,
          Icon(
            CustomIcons.myProfileDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.navMyProfile),
      DrawerItem(
          DrawerEnum.changePassword,
          Icon(
            CustomIcons.changePasswordDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.changePassword),
      DrawerItem(
          DrawerEnum.selectStore,
          Icon(CustomIcons.selectStore, color: iconColor, size: iconSize),
          languages.selectStore),
      DrawerItem(
          DrawerEnum.orderHistory,
          Icon(
            CustomIcons.earningPastOrderDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.navOrderHistory),
      DrawerItem(
          DrawerEnum.product,
          Icon(
            CustomIcons.productsDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.navProducts),
      DrawerItem(
          DrawerEnum.bankDetail,
          Icon(
            CustomIcons.bankDetailsDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.navBankDetail),
      if (showWalletTransferModule)
        DrawerItem(
            DrawerEnum.wallet,
            Icon(
              CustomIcons.wallet,
              color: iconColor,
              size: iconSize,
            ),
            languages.wallet),
      DrawerItem(
          DrawerEnum.preference,
          Icon(
            CustomIcons.preferenceDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.preferences),
      if (showChatWithAdmin)
        DrawerItem(
            DrawerEnum.chatWithAdmin,
            Icon(
              CustomIcons.icChatWithAdmin,
              color: iconColor,
              size: iconSize,
            ),
            languages.chatWithAdmin),
      DrawerItem(
          DrawerEnum.support,
          Icon(
            CustomIcons.supportDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.navSupport),
      DrawerItem(
          DrawerEnum.offer,
          Icon(
            CustomIcons.offerDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.navOffer),
      DrawerItem(
          DrawerEnum.setting,
          Icon(
            CustomIcons.settingDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.navSetting),
      DrawerItem(
          DrawerEnum.liveChat,
          Icon(
            CustomIcons.liveChatDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.liveChat),
      DrawerItem(
          DrawerEnum.logout,
          Icon(
            CustomIcons.logoutDrawerIc,
            color: iconColor,
            size: iconSize,
          ),
          languages.logout)
    ];
    return menus;
  }
}

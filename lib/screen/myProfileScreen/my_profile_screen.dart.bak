// Path: lib/screen/myProfileScreen/my_profile_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

import '../../commonView/customCountryCodePicker/custom_country_code_picker.dart';
import '../../commonView/custom_text_field.dart';
import '../../commonView/image_selection.dart';
import '../../commonView/image_with_placeholder.dart';
import '../../commonView/my_widgets.dart';
import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/common_util.dart';
import '../../utils/custom_icons.dart';
import 'my_profile_bloc.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => MyProfileScreenState();
}

class MyProfileScreenState extends State<MyProfileScreen> {
  MyProfileBloc? bloc;

  @override
  void didChangeDependencies() {
    bloc = bloc ?? MyProfileBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var suffix = Container(
        margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.012),
        child: Icon(
          CustomIcons.edit,
          size: iconSize,
          color: textColorWithOpacity,
        ));
    var hintStyle = bodyText(fontSize: textSizeSmall);
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        title: Text(
          languages.navMyProfile,
          style: toolbarStyle(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.03),
                    child: GestureDetector(
                      onTap: () {
                        selectImgFromCameraOrGallery(context, (file) {
                          bloc?.changeProfileFile(file);
                          bloc!.buttonHide();
                        });
                      },
                      child: StreamBuilder<String>(
                          stream: bloc!.profileImageStored,
                          builder: (context, snapshotPref) {
                            return Column(
                              children: [
                                StreamBuilder<File>(
                                    stream: bloc!.profileFile,
                                    builder: (context, snapshot) {
                                      ImageProvider file;
                                      if (snapshot.hasData && snapshot.data != null) {
                                        file = FileImage(snapshot.data!);
                                      } else if (snapshotPref.hasData && snapshotPref.data != null && (snapshotPref.data) != null) {
                                        file = NetworkImage(snapshotPref.data!);
                                      } else {
                                        file = const AssetImage("assets/images/avatar_store.png");
                                      }
                                      return Hero(
                                        tag: "profile",
                                        child: ImageWithPlaceholder(
                                          image: file,
                                          errorHolder: Image.asset(
                                            "assets/images/avatar_store.png",
                                            fit: BoxFit.cover,
                                            height: double.infinity,
                                            width: double.infinity,
                                          ),
                                          placeholder: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade100,
                                            child: Image.asset(
                                              "assets/images/ic_login_logo.png",
                                              fit: BoxFit.scaleDown,
                                              height: double.infinity,
                                              width: double.infinity,
                                            ),
                                          ),
                                          radius: deviceAverageSize * 0.135,
                                          isCircular: true,
                                        ),
                                      );
                                    }),
                                Padding(
                                  padding: EdgeInsets.all(deviceAverageSize * 0.012),
                                  child: Text(
                                    languages.changePicture,
                                    textAlign: TextAlign.center,
                                    style: bodyText(fontSize: textSizeBig, textColor: colorPrimary, fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.012, horizontal: deviceWidth * 0.035),
                    child: TextFormFieldCustom(
                      textInputAction: TextInputAction.next,
                      controller: bloc!.fullName,
                      suffix: suffix,
                      style: bodyText(),
                      setError: true,
                      useLabelWithBorder: true,
                      decoration: InputDecoration(labelText: languages.fullName),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        bloc!.buttonHide();
                        if (value.isEmpty) {
                          return languages.enterFullName;
                        }
                        return "";
                      },
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.035),
                      child: Row(
                        children: [
                          Text(
                            languages.gender,
                            style: hintStyle,
                          ),
                          Gender(bloc!),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.012, horizontal: deviceWidth * 0.035),
                    child: TextFormFieldCustom(
                      textInputAction: TextInputAction.next,
                      controller: bloc!.email,
                      suffix: suffix,
                      keyboardType: TextInputType.emailAddress,
                      useLabelWithBorder: true,
                      decoration: InputDecoration(labelText: languages.email),
                      setError: true,
                      style: bodyText(),
                      validator: (value) {
                        bloc!.buttonHide();
                        if (value.isEmpty) {
                          return languages.enterEmailAddress;
                        }
                        var hasMatchEmail = emailRegExp(value);

                        if (!hasMatchEmail) return languages.invalidEmailAddress;

                        return "";
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.012, horizontal: deviceWidth * 0.035),
                    child: TextFormFieldCustom(
                      textInputAction: TextInputAction.done,
                      controller: bloc!.contactNumber,
                      readOnly: false,
                      useLabelWithBorder: true,
                      decoration: InputDecoration(labelText: languages.contactNumber),
                      prefix: CustomCountryCodePicker(
                        onChanged: (value) {
                          bloc?.countryCode = "$value";
                        },
                        initialSelection: prefGetString(prefCountryCode),
                        onInit: (value) {
                          bloc?.countryCode = "$value";
                        },
                        showFlag: false,
                        showFlagDialog: true,
                        showOnlyCountryWhenClosed: false,
                        showDropDownButton: true,
                        alignLeft: false,
                        textStyle: bodyText(),
                        dialogTextStyle: bodyText(),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      suffix: suffix,
                      setError: true,
                      validator: (value) {
                        bloc!.buttonHide();
                        if (value.isEmpty) {
                          return languages.enterContactNumber;
                        }
                        return "";
                      },
                      style: bodyText(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: StreamBuilder<ApiResponse<BaseModel>>(
                          stream: bloc!.deleteAccountSubject,
                          builder: (context, snapshot) {
                            return CustomRoundedButton(
                              context,
                              languages.delete,
                              () {
                                bloc?.openDeleteAccountDialog();
                              },
                              setProgress: (snapshot.hasData && snapshot.data != null) ? ((snapshot.data?.status ?? Status.completed) == Status.loading) : false,
                              minHeight: commonBtnHeight,
                              fontWeight: FontWeight.w700,
                              textSize: textSizeLarge,
                              margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.035, end: deviceWidth * 0.02, bottom: deviceHeight * 0.03, top: deviceHeight * 0.02),
                              minWidth: double.infinity,
                            );
                          }),
                    ),
                    Expanded(
                      flex: 1,
                      child: StreamBuilder<ApiResponse<bool>>(
                        stream: bloc!.updateProfile,
                        builder: (context, snapshot) {
                          return StreamBuilder<bool>(
                              stream: bloc!.updateEnable,
                              builder: (context, updateEnable) {
                                return CustomRoundedButton(
                                  context,
                                  languages.update,
                                  (updateEnable.data ?? false)
                                      ? () {
                                          final isValid = formKey.currentState!.validate();
                                          if (isValid) {
                                            bloc?.updateProfileCall();
                                          }
                                        }
                                      : null,
                                  setProgress: (snapshot.hasData && snapshot.data != null) ? ((snapshot.data?.status ?? Status.completed) == Status.loading) : false,
                                  minHeight: commonBtnHeight,
                                  fontWeight: FontWeight.w700,
                                  textSize: textSizeLarge,
                                  margin: EdgeInsetsDirectional.only(
                                    start: deviceWidth * 0.02,
                                    end: deviceWidth * 0.035,
                                    bottom: deviceHeight * 0.03,
                                    top: deviceHeight * 0.02,
                                  ),
                                  minWidth: double.infinity,
                                );
                              });
                        },
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class Gender extends StatelessWidget {
  final MyProfileBloc bloc;

  const Gender(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenderEnum>(
        stream: bloc.genderEnum,
        builder: (context, snapshot) {
          GenderEnum gender = snapshot.hasData && snapshot.data != null ? snapshot.data! : GenderEnum.male;

          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  bloc.changeGenderEnum(GenderEnum.male);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: GenderEnum.male,
                      groupValue: gender,
                      onChanged: (gender) {
                        if (gender != null) {
                          bloc.changeGenderEnum(gender);
                        }
                      },
                    ),
                    Text(
                      languages.male,
                      style: bodyText(),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  bloc.changeGenderEnum(GenderEnum.female);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: GenderEnum.female,
                        groupValue: gender,
                        onChanged: (gender) {
                          if (gender != null) {
                            bloc.changeGenderEnum(gender);
                          }
                        },
                      ),
                      Text(
                        languages.female,
                        style: bodyText(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}

import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/profile_model.dart';
import 'package:base_bloc/data/model/user_profile_model.dart';
import 'package:base_bloc/modules/bonjour/client/client_page.dart';
import 'package:base_bloc/modules/bonjour/server/server_page.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../localization/locale_keys.dart';
import '../theme/colors.dart';
import 'app_text.dart';

class ProfileInfoWidget extends StatelessWidget {
  final UserProfileModel profileModel;
  final VoidCallback onPressEditProfile;
  static double _avatarSize = 56.w;

  const ProfileInfoWidget(
      {Key? key, required this.profileModel, required this.onPressEditProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorMainBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 2 * contentPadding,
                left: 2 * contentPadding,
                right: 2 * contentPadding),
            child: Row(
              children: [
                CircleAvatar(
                  radius: _avatarSize / 2.0,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                      child: Image.network(
                    profileModel.photo ?? '',
                    fit: BoxFit.cover,
                    width: _avatarSize,
                    height: _avatarSize,
                  )),
                ),
                SizedBox(width: 2 * contentPadding),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      AppText(profileModel.firstName ?? '',
                          style: googleFont.copyWith(
                              color: colorMainText,
                              fontSize: 22.w,
                              fontWeight: FontWeight.w600)),
                      AppText(profileModel.lastName ?? '',
                          style: googleFont.copyWith(
                              color: colorMainText,
                              fontSize: 22.w,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  AppText(profileModel.role ?? '',
                      style: googleFont.copyWith(
                          color: colorSubText,
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400))
                ])
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(color: colorWhite.withOpacity(0.12), height: 1.h),
          _userCountInfoWidget(context),
          _userActionsWidget(context),
          _bonjourService(context)
        ],
      ),
    );
  }

  /* Show user count info: passed, dessigned, friends */
  Widget _userCountInfoWidget(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 2 * contentPadding,
            left: 2 * contentPadding,
            right: 2 * contentPadding),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(LocaleKeys.countPassed.tr(),
                    style: googleFont.copyWith(
                        color: colorMainText,
                        fontSize: 10.w,
                        fontWeight: FontWeight.w600)),
                AppText("32",
                    style: googleFont.copyWith(
                        color: colorMainText,
                        fontSize: 24.w,
                        fontWeight: FontWeight.w700))
              ],
            ),
            SizedBox(width: 40.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(LocaleKeys.countDesigned.tr(),
                    style: googleFont.copyWith(
                        color: colorMainText,
                        fontSize: 10.w,
                        fontWeight: FontWeight.w600)),
                AppText("12",
                    style: googleFont.copyWith(
                        color: colorMainText,
                        fontSize: 24.w,
                        fontWeight: FontWeight.w700))
              ],
            ),
            SizedBox(width: 40.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(LocaleKeys.countFriends.tr(),
                    style: googleFont.copyWith(
                        color: colorMainText,
                        fontSize: 10.w,
                        fontWeight: FontWeight.w600)),
                AppText("24",
                    style: googleFont.copyWith(
                        color: colorMainText,
                        fontSize: 24.w,
                        fontWeight: FontWeight.w700))
              ],
            )
          ],
        ));
  }

  /* Custom actions: Edit settings, Add/Remove friends, Message */
  Widget _userActionsWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 2 * contentPadding,
          left: 2 * contentPadding,
          right: 2 * contentPadding),
      child: TextButton(
          style: TextButton.styleFrom(
            primary: colorMainText,
            onSurface: colorMainBackground,
            side: BorderSide(color: colorMainText, width: 1.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.w))),
          ),
          onPressed: () => onPressEditProfile(),
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Text(LocaleKeys.editSettings.tr(),
                style: googleFont.copyWith(
                    color: colorMainText,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w400)),
          )),
    );
  }
  Widget _bonjourService(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: 2 * contentPadding,
              left: 2 * contentPadding,
              right: 2 * contentPadding),
          child: TextButton(
              style: TextButton.styleFrom(
                primary: colorMainText,
                onSurface: colorMainBackground,
                side: BorderSide(color: colorMainText, width: 1.w),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.w))),
              ),
              onPressed: () =>
                  RouterUtils.openNewPage(const ClientPage(), context),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Text("CLIENT",
                    style: googleFont.copyWith(
                        color: colorMainText,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400)),
              )),
        ),
        Container(
          padding: EdgeInsets.only(
              top: 2 * contentPadding,
              left: 2 * contentPadding,
              right: 2 * contentPadding),
          child: TextButton(
              style: TextButton.styleFrom(
                primary: colorMainText,
                onSurface: colorMainBackground,
                side: BorderSide(color: colorMainText, width: 1.w),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.w))),
              ),
              onPressed: () => RouterUtils.openNewPage(ServerPage(), context),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Text("SERVER",
                    style: googleFont.copyWith(
                        color: colorMainText,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400)),
              )),
        )
      ],
    );
  }
}

import 'package:base_bloc/components/app_circle_image.dart';
import 'package:base_bloc/components/app_network_image.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text_field.dart';
import 'package:base_bloc/components/appbar_widget.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/routes_model.dart';
import 'package:base_bloc/modules/bonjour/server/server_cubit.dart';
import 'package:base_bloc/modules/bonjour/server/server_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/app_not_data_widget.dart';
import '../../../components/app_text.dart';
import '../../../data/model/user_profile_model.dart';
import '../../../localization/locale_keys.dart';
import '../../../utils/app_utils.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({Key? key}) : super(key: key);

  @override
  State<ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  final _bloc = ServerCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appbar: appBarWidget(
            context: context,
            title: AppText("All user", style: typoW400.copyWith())),
        body: BlocBuilder<ServerCubit, ServerState>(
          builder: (BuildContext context, state) => state.lUser.isEmpty
              ? const Center(child: AppNotDataWidget(message: "NO USER LOGGED",))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    infoUserWidget(state),
                    Container(
                        width: 6,
                        height: MediaQuery.of(context).size.height,
                        color: colorBlack,
                        margin: const EdgeInsets.only(right: 10)),
                    infoRouteWidget(state)
                  ],
                ),
          bloc: _bloc,
        ));
  }

  Widget infoRouteWidget(ServerState state) => Expanded(
      flex: 10,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < state.lRoute.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(state.lUser[i].lastName ?? '',
                      style: typoW400.copyWith()),
                  ListView.separated(
                      padding: const EdgeInsets.only(right: 20),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (c, index) =>
                          itemRouteWidget(state.lRoute[i][index]),
                      itemCount: state.lRoute[i].length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10))
                ],
              )
          ],
        ),
      ));

  Widget itemRouteWidget(RoutesModel model) {
    var infoBackground = Utils.getBackgroundColor(model.authorGrade ?? 0);
    return Container(
      padding:
          EdgeInsets.only(left: contentPadding, right: contentPadding + 10),
      height: 40.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              stops: infoBackground.stops, colors: infoBackground.colors)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: model.hasConner == false
                ? Center(
                    child: AppText(Utils.getGrade(model.authorGrade ?? 0),
                        style: googleFont.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorText0,
                            fontSize: 20.sp)),
                  )
                : Center(
                    child: Column(
                      children: [
                        AppText(
                          Utils.getGrade(model.authorGrade ?? 0),
                          style: googleFont.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorText0,
                              fontSize: 10.sp),
                          textAlign: TextAlign.end,
                        ),
                        AppText(
                          " ${LocaleKeys.corner.tr()}",
                          textAlign: TextAlign.start,
                          style: typoW400.copyWith(
                              color: colorWhite.withOpacity(0.87)),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    model.name ?? '',
                    style: googleFont.copyWith(
                        color: colorText0.withOpacity(0.87),
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp),
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  (model.published ?? true)
                      ? Row(
                          children: [
                            AppText(
                              '${LocaleKeys.routes.tr()} ${model.height}m ',
                              style: googleFont.copyWith(
                                  color: colorText0.withOpacity(0.6),
                                  fontSize: 9.sp),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: const Icon(
                                Icons.circle_sharp,
                                size: 6,
                                color: colorWhite,
                              ),
                            ),
                            Expanded(
                                child: AppText(
                                    model.userProfile != null
                                        ? " ${model.userProfile?.firstName} ${model.userProfile?.lastName}"
                                        : " ${model.authorFirstName} ${model.authorLastName}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLine: 1,
                                    style: googleFont.copyWith(
                                        color: colorText0.withOpacity(0.6),
                                        fontSize: 9.sp)))
                          ],
                        )
                      : Row(children: [
                          AppText(
                            '${LocaleKeys.routes.tr()} ${model.height}m ',
                            style: googleFont.copyWith(
                                color: colorText0.withOpacity(0.6),
                                fontSize: 13.sp),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: const Icon(
                              Icons.circle_sharp,
                              size: 6,
                              color: colorWhite,
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: colorWhite),
                              padding: EdgeInsets.only(
                                  left: 7.w, right: 7.w, top: 2.h, bottom: 2.h),
                              child: AppText(LocaleKeys.draft.tr(),
                                  style: typoW400.copyWith(
                                      fontSize: 11.sp, color: colorText90)))
                        ])
                ],
              ))
        ],
      ),
    );
  }

  Widget infoUserWidget(ServerState state) => Expanded(
        flex: 3,
        child: ListView.builder(
            padding: EdgeInsets.all(contentPadding),
            itemCount: state.lDevice != null ? state.lUser.length : 0,
            itemBuilder: (BuildContext context, int index) =>
                itemUser(state.lUser[index])),
      );

  Widget itemUser(UserProfileModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppCircleImage(url: model.photo, urlError: "", height: 30, width: 30),
          AppText(
            model.lastName ?? "",
            style: typoW400.copyWith(),
            maxLine: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      );
}

import 'dart:math';

import 'package:badges/badges.dart';
import 'package:base_bloc/components/profile_info_widget.dart';
import 'package:base_bloc/data/model/user_model.dart';
import 'package:base_bloc/localizations/app_localazations.dart';
import 'package:base_bloc/modules/tab_profile/tab_profile_cubit.dart';
import 'package:base_bloc/modules/tab_profile/tab_profile_post/tab_profile_post.dart';
import 'package:base_bloc/modules/tab_profile/tab_profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../localizations/app_localazations.dart';
import 'dart:math' as math;

import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../theme/colors.dart';
import '../designed/designed_page.dart';
import '../favourite/favourite_page.dart';
import '../history/history_page.dart';

class TabProfile extends StatefulWidget {
  const TabProfile({Key? key}) : super(key: key);

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {
  late final TabProfileCubit _bloc;

  @override
  void initState() {
    _bloc = TabProfileCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF3B4244),
      appBar: appBar(context),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: colorGrey90,
            appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height),
                child: NestedScrollView(
                  headerSliverBuilder: (context, value) {
                    return [
                      SliverAppBar(
                          elevation: 0,
                          toolbarHeight: 270.0,
                          floating: false,
                          pinned: false,
                          flexibleSpace:
                              _buildProfileInfoHeaderSliverAppBarFlex()),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          minHeight: 44,
                          maxHeight: 44,
                          child: TabBar(
                            labelColor: Colors.orange,
                            labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.orange,
                            indicatorWeight: 3.0,
                            tabs: [
                              Tab(text: AppLocalizations.of(context)!.tabPosts),
                              Tab(text: AppLocalizations.of(context)!.tabHistory),
                              Tab(text: AppLocalizations.of(context)!.tabDesigned),
                            ],
                          ),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    children: [
                      TabProfilePost(),
                      HistoryPage(),
                      DesignedPage()
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfoHeaderSliverAppBarFlex() =>
      BlocBuilder<TabProfileCubit, TabProfileState>(
          bloc: _bloc,
          builder: (BuildContext context, state) {
            return ProfileInfoWidget(userModel: _bloc.getCurrentUser(),
                onPressEditProfile: () => _bloc.didPressEditProfile(context));
          });

  PreferredSizeWidget appBar(BuildContext context) => AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          SizedBox(
            width: 15.w,
          ),
          SizedBox(
            child: Badge(
              padding: const EdgeInsets.all(2),
              position: BadgePosition.topEnd(top: 13.h, end: -2.h),
              toAnimate: false,
              badgeContent: const Text('1'),
              child: const Icon(Icons.notifications_none_sharp),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
        ],
      );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
        child: Container(
      color: Colors.black,
      child: child,
    ));
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
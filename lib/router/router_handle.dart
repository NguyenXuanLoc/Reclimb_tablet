import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/model/reservation_model.dart';
import 'package:base_bloc/data/model/routes_model.dart';
import 'package:base_bloc/modules/create_reservation/create_reservation_page.dart';
import 'package:base_bloc/modules/home/home_page.dart';
import 'package:base_bloc/modules/reservation_detail/reservation_detail_page.dart';
import 'package:base_bloc/modules/splash/splash_page.dart';
import 'package:base_bloc/modules/tab_climb/tab_climp.dart';
import 'package:base_bloc/modules/tab_home/tab_home.dart';
import 'package:base_bloc/modules/tab_profile/tab_profile.dart';
import 'package:base_bloc/modules/tab_reservation/tab_reservation.dart';
import 'package:base_bloc/modules/tab_routes/tab_routes.dart';
import 'package:fluro/fluro.dart';

import '../modules/routers_detail/routes_detail_page.dart';

var routeRoutesDetail = Handler(
    handlerFunc: (c, p) => RoutesDetailPage(
          index: (c!.settings!.arguments as List)[0] as int,
          model: (c.settings!.arguments as List)[1] as RoutesModel,
        ));
var routeSplash = Handler(handlerFunc: (c, p) => const SplashPage());
var routeHome = Handler(handlerFunc: (c, p) => const HomePage());
var routeTabHome = Handler(handlerFunc: (c, p) => const TabHome());
var routeTabClimb = Handler(handlerFunc: (c, p) => const TabClimb());
var routeTabProfile = Handler(handlerFunc: (c, p) => const TabProfile());
var routeTabReservation =
    Handler(handlerFunc: (c, p) => const TabReservation());
var routeTabRoutes = Handler(handlerFunc: (c, p) => const TabRoutes());
var routeReservationDetail = Handler(
    handlerFunc: (c, p) => ReservationDetailPage(
          index: BottomNavigationConstant.TAB_RESERVATIONS,
          model: c!.settings!.arguments as ReservationModel,
        ));
var routeCreateReservationPage =
    Handler(handlerFunc: (c, p) => const CreateReservationPage());

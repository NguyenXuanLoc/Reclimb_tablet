import 'package:base_bloc/router/router_handle.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routers {
  static String root = "/";
  static String home = "/home";
  static String video = '/video';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>>? params) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeSplash);
    router.define(home, handler: routeHome);
    // router.define(test, handler: routeTest);
  }
}

class HomeRouters {
  static String root = '/';
  static String search = '/search_home';
  static String reservation = '/reservation';
  static String notifications = '/notifications';

  static configureMainRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (c, p) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeTabHome);
    router.define(search, handler: routeSearchHome);
    router.define(reservation, handler: routeReservationDetail);
    router.define(notifications, handler: routeNotifications);
  }
}

class RoutesRouters {
  static String root = '/';
  static String routesDetail = '/routesDetail';
  static String createRoutes ='/createRoutes';
  static configureRouter(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (c, x) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeTabRoutes);
    router.define(routesDetail, handler: routeRoutesDetail);
    router.define(createRoutes, handler: routeCreateRoutes);
  }
}

class ClimbRouters {
  static String root = '/';

  static configureRouter(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (c, x) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeTabClimb);
  }
}

class ReservationRouters {
  static String root = '/';
  static String routesReservationDetail = '/reservationDetail';
  static String routesCreateReservationPage = '/createReservationPage';
  static String routesFilterAddress = '/routesFilterCity';
  static String routesFindPlace = '/routeFindPlace';
  static String routesConfirmCreateReservation = '/routesConfirmCreateReservation';
  static String routesCreateReservationSuccess =
      'routesCreateReservationSuccess';
  static configureRouter(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (c, x) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeTabReservation);
    router.define(routesReservationDetail, handler: routeReservationDetail);
    router.define(routesCreateReservationPage, handler: routeCreateReservationPage);
    router.define(routesFilterAddress, handler: routeFilterAddress);
    router.define(routesFindPlace, handler: routeFindPlace);
    router.define(routesConfirmCreateReservation,
        handler: routeConfirmCreateReservation);
    router.define(routesCreateReservationSuccess,
        handler: routeCreateReservationSuccess);
  }
}

class ProfileRouters {
  static String root = '/';

  static configureProfileRouter(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (c, x) {
      logE('ROUTE WAS NOT FOUND !!!');
    });
    router.define(root, handler: routeTabProfile);
  }
}

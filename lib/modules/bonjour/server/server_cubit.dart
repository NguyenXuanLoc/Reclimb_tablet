import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/model/device_model.dart';
import 'package:base_bloc/data/model/routes_model.dart';
import 'package:base_bloc/data/repository/user_repository.dart';
import 'package:base_bloc/modules/bonjour/server/server_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user_profile_model.dart';

class ServerCubit extends Cubit<ServerState> {
  var userRepository = UserRepository();

  ServerCubit()
      : super(ServerState(
            lRoute: List.empty(growable: true),
            lDevice: List.empty(growable: true),
            lUser: List.empty(growable: true))) {
    listenerData();
  }

  void listenerData() async {
    BonsoirDiscovery discovery =
        BonsoirDiscovery(type: ConstantKey.CLIMBER_SERVICE);
    await discovery.ready;

    discovery.eventStream?.listen((event) async {
      if (event.type == BonsoirDiscoveryEventType.discoveryServiceResolved) {
        bool isExist = false;
        var model = event.service;
        if (model?.attributes == null) return;
        for (int i = 0; i < state.lDevice.length; i++) {
          if (state.lDevice[i].deviceId ==
              model?.attributes?[ApiKey.device_id]) {
            isExist = true;
            break;
          }
        }
        if (!isExist) {
          try {
            var deviceModel = DeviceModel.fromJson(event.service!.attributes!);
            UserProfileModel? userProfile = await getUserProfile(
                deviceModel.userId, deviceModel.accessToken);
            var lRoute = await getRoutes(deviceModel.accessToken);
            if (userProfile != null && lRoute != null) {
              emit(state.copyOf(
                  timeStamp: DateTime.now().microsecondsSinceEpoch,
                  lUser: state.lUser..add(userProfile),
                  lRoute: state.lRoute..add(lRoute),
                  lDevice: state.lDevice
                    ..add(DeviceModel.fromJson(event.service!.attributes!))));
            }
          } catch (ex) {}
        }
      } else if (event.type == BonsoirDiscoveryEventType.discoveryServiceLost) {
        int index = 0;
        bool isExist = false;
        var model = event.service;
        for (int i = 0; i < state.lDevice.length; i++) {
          if (state.lDevice[i].deviceId == model?.name) {
            isExist = true;
            index = i;
          }
        }
        if (isExist) {
          state.lDevice.removeAt(index);
          state.lUser.removeAt(index);
          state.lRoute.removeAt(index);
        }
        emit(state.copyOf(
            lRoute: state.lRoute,
            lDevice: state.lDevice,
            lUser: state.lUser,
            timeStamp: DateTime.now().microsecondsSinceEpoch));
      }
    });
    await discovery.start();
  }

  Future<UserProfileModel?> getUserProfile(String userId, String token) async {
    var response = await userRepository.getUserProfile(int.parse(userId),
        accessToken: token);
    if (response.error == null && response.data != null) {
      return UserProfileModel.fromJson(response.data);
    }
    return null;
  }

  Future<List<RoutesModel>?> getRoutes(String token) async {
    var response = await userRepository.getRouteForUserLoginWall(token);
    if (response.data != null && response.error == null) {
      return routeModelFromJson(response.data);
    }
    return null;
  }
}

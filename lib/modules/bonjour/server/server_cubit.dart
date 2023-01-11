import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/model/device_model.dart';
import 'package:base_bloc/modules/bonjour/server/server_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServerCubit extends Cubit<ServerState> {
  ServerCubit() : super( ServerState(lUser: [])) {
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
        for (int i = 0; i < state.lUser.length; i++) {
          if (state.lUser[i].deviceId == model?.attributes?[ApiKey.device_id]) {
            isExist = true;
            break;
          }
        }
        state.lUser.add(DeviceModel.fromJson(event.service!.attributes!));
        if (!isExist) {
          emit(state.copyOf(
              lUser: [DeviceModel.fromJson(event.service!.attributes!)],
              timeStamp: DateTime.now().microsecondsSinceEpoch));
        }
      } else if (event.type == BonsoirDiscoveryEventType.discoveryServiceLost) {
        int index = 0;
        bool isExist = false;
        var model = event.service;
        for (int i = 0; i < state.lUser.length; i++) {
          if (state.lUser[i].deviceId == model?.name) {
            isExist = true;
            index = i;
          }
        }
        if (isExist) {
          state.lUser.removeAt(index);
        }
        emit(state.copyOf(
            lUser: state.lUser,
            timeStamp: DateTime.now().microsecondsSinceEpoch));
      }
    });
    await discovery.start();
  }
}

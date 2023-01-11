import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/modules/bonjour/client/client_state.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/globals.dart' as globals;

class ClientCubit extends Cubit<ClientState> {
  late BonsoirService service;
  late BonsoirBroadcast broadcast;

  ClientCubit() : super(ClientState(false)) {
    service = BonsoirService(
        name: globals.deviceId,
        type: ConstantKey.CLIMBER_SERVICE,
        port: 3030,
        attributes: {
          ApiKey.device_id: globals.deviceId,
          ApiKey.device_model: globals.deviceModel,
          ApiKey.device_name: globals.deviceName,
          ApiKey.token: globals.accessToken
        });
    broadcast = BonsoirBroadcast(service: service);
  }

  void loginOnClick(BuildContext context) async {
    await broadcast.ready;
    await broadcast.start();
    emit(ClientState(true));
  }

  void logoutOnClick(BuildContext context) async {
    await broadcast.stop();
    emit(ClientState(false));
  }
}

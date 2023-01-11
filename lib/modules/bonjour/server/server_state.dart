import 'package:base_bloc/data/model/device_model.dart';
import 'package:base_bloc/data/model/routes_model.dart';
import 'package:base_bloc/data/model/user_profile_model.dart';
import 'package:equatable/equatable.dart';

class ServerState extends Equatable {
  final List<DeviceModel> lDevice;
  final List<UserProfileModel> lUser;
  final List<List<RoutesModel>> lRoute;
  final int timeStamp;

  const ServerState(
      {this.lDevice = const <DeviceModel>[],
      this.lUser = const [],
      this.lRoute = const [],
      this.timeStamp = 0});

  ServerState copyOf(
          {List<DeviceModel>? lDevice,
          List<UserProfileModel>? lUser,
          List<List<RoutesModel>>? lRoute,
          int? timeStamp}) =>
      ServerState(
          lDevice: lDevice ?? this.lDevice,
          lUser: lUser ?? this.lUser,
          lRoute: lRoute ?? this.lRoute,
          timeStamp: timeStamp ?? this.timeStamp);

  @override
  List<Object?> get props => [lDevice, lUser, lRoute, timeStamp];
}

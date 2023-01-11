import 'package:base_bloc/data/model/device_model.dart';
import 'package:equatable/equatable.dart';

class ServerState extends Equatable {
  List<DeviceModel> lUser;
  final int timeStamp;

  ServerState({this.lUser = const [], this.timeStamp = 0});

  ServerState copyOf({List<DeviceModel>? lUser, int? timeStamp}) => ServerState(
      lUser: lUser ?? this.lUser, timeStamp: timeStamp ?? this.timeStamp);

  @override
  List<Object?> get props => [lUser, timeStamp];
}

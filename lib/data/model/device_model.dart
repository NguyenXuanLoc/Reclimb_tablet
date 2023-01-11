import '../../config/constant.dart';

class DeviceModel {
  final String deviceId;
  final String deviceModel;
  final String deviceName;
  final String accessToken;

  DeviceModel(
      this.deviceId, this.deviceModel, this.deviceName, this.accessToken);

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
      json[ApiKey.device_id],
      json[ApiKey.device_model],
      json[ApiKey.device_name],
      json[ApiKey.token]);
}

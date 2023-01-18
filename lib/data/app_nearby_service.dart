import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

enum DeviceType { advertiser, browser }
class AppNearbyService {
  final DeviceType deviceType =DeviceType.browser;
/*
  AppNearbyService(this.deviceType) {
    init();
  }
*/

  static AppNearbyService instance = AppNearbyService._init();

  factory AppNearbyService() {
    return instance;
  }

  AppNearbyService._init() {
    init();
  }

  late NearbyService nearbyService;
  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;
  List<Device> devices = [];
  List<Device> connectedDevices = [];

  void init() async {
    nearbyService = NearbyService();
    String devInfo = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devInfo = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devInfo = iosInfo.localizedModel;
    }
    await nearbyService.init(
        serviceType: 'dartobservatory',
        deviceName: devInfo,
        strategy: Strategy.P2P_CLUSTER,
        callback: (isRunning) async {
          if (isRunning) {
            if (deviceType == DeviceType.browser) {
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await nearbyService.startBrowsingForPeers();
              logE("TAG BROWSER");
            } else {
              await nearbyService.stopAdvertisingPeer();
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await nearbyService.startAdvertisingPeer();
              await nearbyService.startBrowsingForPeers();
            }
          }
        });
    stateChange();
    receivedStream();
  }

  bool isFirstConnect = false;

  void stateChange() {
    subscription =
        nearbyService.stateChangedSubscription(callback: (devicesList) {
          devicesList.forEach((element) {
            print(
                " deviceId: ${element.deviceId} | deviceName: ${element.deviceName} | state: ${element.state}");
            if (Platform.isAndroid) {
              if (element.state == SessionState.connected) {
                nearbyService.stopBrowsingForPeers();
              } else {
                nearbyService.startBrowsingForPeers();
              }
            }
          });
          devices.clear();
          devices.addAll(devicesList);
          connectedDevices.clear();
          connectedDevices.addAll(
              devicesList.where((d) => d.state == SessionState.connected).toList());
          if(devices.isNotEmpty && !isFirstConnect){
            startConnect(devices[0]);
            isFirstConnect = true;
          }
        });
  }

  void receivedStream() {
    receivedDataSubscription =
        nearbyService.dataReceivedSubscription(callback: (data) {
      print("dataReceivedSubscription: ${jsonEncode(data)}");
      toast(jsonEncode(data));
    });
  }

  void sentMessage(/*Device device, */String data) {
    nearbyService.sendMessage(devices[0].deviceId/*device.deviceId*/, data);
  }

  startConnect(Device device) {
    switch (device.state) {
      case SessionState.notConnected:
        nearbyService.invitePeer(
          deviceID: device.deviceId,
          deviceName: device.deviceName,
        );
        break;
      case SessionState.connected:
        nearbyService.disconnectPeer(deviceID: device.deviceId);
        break;
      case SessionState.connecting:
        break;
    }
  }

  void stop() {
    nearbyService.stopBrowsingForPeers();
    nearbyService.stopAdvertisingPeer();
  }
}

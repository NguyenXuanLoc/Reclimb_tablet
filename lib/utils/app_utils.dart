import 'dart:convert';
import 'dart:math';

import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/model/background_param.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:matrix2d/matrix2d.dart';

class Utils {
  static var METHOD_CHANNEL = "METHOD_CALL_NATIVE";
  static var eventBus = EventBus();

  static fireEvent(dynamic model) => eventBus.fire(model);

  static String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';

    params.forEach((key, value) {
      if (inRecursion) {
        key = '[$key]';
      }
      if (value is String || value is int || value is double || value is bool) {
        query += '$prefix$key=$value';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    query = query.replaceFirst(RegExp('&'), '?');
    return query;
  }

  static void hideKeyboard(BuildContext? context) {
    if (context != null) FocusScope.of(context).requestFocus(FocusNode());
  }

  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static BackgroundParam getBackgroundColor(int value) {
    switch (value) {
      case 0: // 4
        return BackgroundParam([HexColor('005926')], [1]);
      case 1: // 5A
        return BackgroundParam(
            [HexColor('746A11'), HexColor('005926'), HexColor('005926')],
            [0, 0.2827, 1]);
      case 2: // 5B
        return BackgroundParam(
            [HexColor('746A11'), HexColor('005926'), HexColor('005926')],
            [0, 0.3994, 1]);
      case 3: // 5C
        return BackgroundParam([
          HexColor('D17800'),
          HexColor('D17800'),
          HexColor('005926'),
          HexColor('005926')
        ], [
          0,
          0.0243,
          0.5193,
          1
        ]);
      case 4: // 6A
        return BackgroundParam([
          HexColor('D17800'),
          HexColor('D17800'),
          HexColor('005926'),
          HexColor('005926')
        ], [
          0,
          0.1419,
          0.6315,
          1
        ]);
      case 5: //6A+
        return BackgroundParam([
          HexColor('D17800'),
          HexColor('D17800'),
          HexColor('005926'),
          HexColor('005926')
        ], [
          0,
          0.2518,
          0.7525,
          1
        ]);
      case 6: //6B
        return BackgroundParam([
          HexColor('D17800'),
          HexColor('D17800'),
          HexColor('005926'),
          HexColor('005926')
        ], [
          0,
          0.3736,
          0.8711,
          1
        ]);
      case 7: //6B+
        return BackgroundParam([
          HexColor('D17800'),
          HexColor('D17800'),
          HexColor('005926'),
          HexColor('005926')
        ], [
          0,
          0.4881,
          0.9837,
          1
        ]);
      case 8: //6C
        return BackgroundParam([
          HexColor('D15600'),
          HexColor('D17800'),
          HexColor('D17800'),
          HexColor('2A5F1E')
        ], [
          0,
          0.2715,
          0.6058,
          1
        ]);
      /*  case 9: //6C+
        return BackgroundParam([
          HexColor('D14800'),
          HexColor('D17800'),
          HexColor('D17800'),
          HexColor('5C6715')
        ], [
          0,
          0.3928,
          0.7265,
          1
        ]);*/
      case 9: //7A
        return BackgroundParam([
          HexColor('D14800'),
          HexColor('D17800'),
          HexColor('CD7701'),
          HexColor('8D6E0C')
        ], [
          0,
          0.5033,
          0.8421,
          1
        ]);
      case 10: //7A+
        return BackgroundParam([
          HexColor('D12B00'),
          HexColor('D17800'),
          HexColor('CB7701'),
          HexColor('BC7504')
        ], [
          0,
          0.622,
          0.9603,
          1
        ]);
      case 11: //7B
        return BackgroundParam(
            [HexColor('D11D00'), HexColor('D17800'), HexColor('D17800')],
            [0, 0.743, 1]);
      case 12: //7B+
        return BackgroundParam(
            [HexColor('D11D00'), HexColor('D17800'), HexColor('D17800')],
            [0, 0.859, 1]);
      case 13: //7C
        return BackgroundParam([
          HexColor('D10B00'),
          HexColor('D10C00'),
          HexColor('D17800'),
          HexColor('D17800')
        ], [
          0,
          0.0895,
          0.973,
          1
        ]);
      case 14: //7C+
        return BackgroundParam([
          HexColor('D10B00'),
          HexColor('D10C00'),
          HexColor('D16D00'),
        ], [
          0,
          0.2102,
          1
        ]);
      case 15: //8A
        return BackgroundParam([
          HexColor('D10000'),
          HexColor('D10000'),
          HexColor('D15B00'),
        ], [
          0,
          0.3276,
          1
        ]);
      case 16: //8A+
        return BackgroundParam([
          HexColor('D10000'),
          HexColor('D10000'),
          HexColor('D14C00'),
        ], [
          0,
          0.4413,
          1
        ]);
      case 17: //8B
        return BackgroundParam([
          HexColor('D10000'),
          HexColor('D10000'),
          HexColor('D13B00'),
        ], [
          0,
          0.5634,
          1
        ]);
      case 18: //8B+
        return BackgroundParam([
          HexColor('D10000'),
          HexColor('D10000'),
          HexColor('D12B00'),
        ], [
          0,
          0.6768,
          1
        ]);
      case 19: //8C
        return BackgroundParam([
          HexColor('D10000'),
          HexColor('D10000'),
          HexColor('D11B00'),
        ], [
          0,
          0.794,
          1
        ]);
      case 20: //8C+
        return BackgroundParam([
          HexColor('D10000'),
        ], [
          1
        ]);
      default:
        return BackgroundParam([
          HexColor('D10000'),
        ], [
          1
        ]);
    }
  }

  static String getGrade(int value) {
    switch (value) {
      case 0:
        return '4';
      case 1:
        return "5A";
      case 2:
        return "5B";
      case 3:
        return "5C";
      case 4:
        return "6A";
      case 5:
        return "6A+";
      case 6:
        return "6B";
      case 7:
        return "6B+";
      case 8:
        return "6C";
      case 9:
        return "7A";
      case 10:
        return "7A+";
      case 11:
        return "7B";
      case 12:
        return "7B+";
      case 13:
        return "7C";
      case 14:
        return "7C+";
      case 15:
        return "8A";
      case 16:
        return "8A+";
      case 17:
        return "8B";
      case 18:
        return "8B+";
      case 19:
        return "8C";
      case 20:
        return "8C+";
      default:
        return '';
    }
  }

  static bool validatePassword(String value) {
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static String convertTimeToDDMMHH(DateTime? time) {
    if (time == null) return '';
    var result = DateFormat('dd-MM-yyyy').format(time);
    return result.toString().split(' ')[0];
  }

  static String convertTimeToYYMMDDFromStr(String time) {
    var result = time.split('-');
    return '${result[2]}-${result[1]}-${result[0]}';
  }

  static String getFullTimeFromStr(String time) {
    var result = time.split(':');
    return "${result[0]}:${(result[1].length == 1 ? "0" + result[1] : result[1])}";
  }

  static String getFullHoursFromStr(String time) {
    var result = time.split(':');
    return "${(result[0].length == 1 ? "0" + result[0] : result[0])}:${(result[1].length == 1 ? "0" + result[1] : result[1])}";
  }

  static String convertTimeToYYMMDDFromDateTime(DateTime time) =>
      DateFormat('yyyy-MM-dd').format(time).toString();

  static String convertTimeToDDMMYYFromStr(String time) =>
      DateFormat('dd-MM-yyyy').parse(time).toString();

  static String convertTimeToDDMMYYFromDateTime(DateTime time) =>
      DateFormat('dd-MM-yyyy').format(time).toString();

  static String convertTimeToMMMDDYYYYHOUR(DateTime? time) =>
      DateFormat('MMM dd yyyy, HH:MM')
          .format(time ?? DateTime.now())
          .toString();

  static String convertTimeToMMMDDYYYY(DateTime? time) =>
      DateFormat('MMM dd yyyy').format(time ?? DateTime.now()).toString();

  static String convertTimeToDDMMYYHHMMFromDateTime(DateTime time) =>
      DateFormat('dd/MM/yyyy - hh:mm').format(time).toString();

  static String convertTimeToYYHHFromDateTime(DateTime time) =>
      DateFormat('hh:mm').format(time).toString();

  static String convertTimeToMMMYYDD(DateTime time) =>
      DateFormat('dd - MMM').format(time).toString();

  static String convertHoursFromStr(String? input) {
    if (input == null || input.isEmpty) return '';
    var time = parseTimeOfDay(input);
    var hour = time.hour.toString().length == 1
        ? "0" + time.hour.toString()
        : time.hour.toString();
    var minute = time.minute.toString().length == 1
        ? "0" + time.minute.toString()
        : time.minute.toString();
    return "$hour:$minute";
  }

  static TimeOfDay parseTimeOfDay(String t) {
    DateTime dateTime = DateFormat("HH:mm").parse(t);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  static String convertTimeStampToYYYYMMYY(int timestamp) =>
      DateFormat('yyyy-MM-dd')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));

  static String reformatDateToMMMDDYYFromStr(String dateTime) {
    return DateFormat('MMM DD YYYY').parse(dateTime).toString();
  }

  static DateTime convertStringToDate(String date) =>
      DateFormat('yy-MM-dd').parse(date);

  static String convertDateToMMYYYY(DateTime date) =>
      DateFormat('MM/yyyy').format(date);

  static String formatMoney(int? money) =>
      NumberFormat('#,###,###,#,###,###,###', 'vi').format(money ?? 0);

  static String randomTag() => Random().nextInt(100).toString();

  static String convertDateToYYYYMMDD(DateTime dateTime) =>
      DateFormat('yyyy-MM-dd').format(dateTime);

  static String convertDateTimeToEEE(DateTime dateTime) =>
      DateFormat('EEE').format(dateTime);

  static String convertDateTimeToEEEDDMMM(DateTime dateTime) =>
      DateFormat('EEE, d MMMM').format(dateTime);

  static String convertDateTimeToDD(DateTime dateTime) =>
      DateFormat('dd').format(dateTime);

  static LinearGradient backgroundGradientOrangeButton(
          {AlignmentGeometry? begin, AlignmentGeometry? end}) =>
      LinearGradient(
          begin: begin ?? Alignment.topCenter,
          end: end ?? Alignment.bottomCenter,
          colors: [
            HexColor('FF9300'),
            HexColor('FF5A00'),
            HexColor('FF5A00'),
          ]);

  static int getPosition(x, y, width) {
    x += 1;
    y += 1;
    return x - 1 + (y - 1) * width;
  }

  static String getUrlHoldSet(int id) =>
      "${ConstantKey.BASE_URL}hold/${id}/image";

  static int getRotateByDirection(String value) {
    switch (value) {
      case 'N':
        return 0;
      case 'E':
        return 1;
      case 'S':
        return 2;
      case 'M':
        return 3;
      default:
        return 0;
    }
  }
}

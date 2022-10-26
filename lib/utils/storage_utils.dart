import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/globals.dart' as globals;
import 'package:get_storage/get_storage.dart';

import '../data/globals.dart';

class StorageUtils {
  static void setLogin(bool isLogin) {
    GetStorage().write(StorageKey.isLogin, isLogin);
    globals.isLogin = isLogin;
  }

  static Future<void> getLogin() async {
    var isLogin = await GetStorage().read(StorageKey.isLogin);
    if(isLogin != null) {
      globals.isLogin = isLogin;
    }
  }

/*static Future<void> saveDoctorRatingLatest(List<RatingModel> lDoctor) async {
    var json = jsonEncode(lDoctor.map((e) => e.toJson()).toList());
    await GetStorage().write(StorageKey.ratingLatest, json);
  }
  static Future<List<RatingModel>?> getDoctorRatingLatest() async {
    var response = await GetStorage().read(StorageKey.ratingLatest);
    if (response != null) {
      try {
        List<dynamic> lDoctor = json.decode(response);
        return List<RatingModel>.from(
            lDoctor.map((x) => RatingModel.fromJson(x)));
      } catch (ex) {}
    }
    return null;
  }

  static Future<void> saveDoctorPromote(List<DoctorModel> lDoctor) async {
    var json = jsonEncode(lDoctor.map((e) => e.toJson()).toList());
    await GetStorage().write(StorageKey.doctorPromote, json);
  }

  static Future<List<DoctorModel>?> getDoctorPromote() async {
    var response = await GetStorage().read(StorageKey.doctorPromote);
    if (response != null) {
      try {
        List<dynamic> lDoctor = json.decode(response);
        return List<DoctorModel>.from(
            lDoctor.map((x) => DoctorModel.fromJson(x)));
      } catch (ex) {}
    }
    return null;
  }


  static Future<void> clearData() async {
    globals.accessToken = '';
    globals.avatar ='';
    globals.accountId = '';
    globals.userName = '';
    globals.refreshToken = '';
    globals.isLogin = false;
    setLoginByFbOrGg(false);
    GetStorage().remove(StorageKey.AccountInfo);
  }

  static Future<UserResponse?> getUser() async {
    try {
      var userString = await GetStorage().read(StorageKey.AccountInfo);
      var result = UserResponse.fromJson(userString);
      globals.accessToken = result.token;
      globals.refreshToken = result.refreshToken??'';
      globals.accountId = result.userId.toString();
      globals.avatar = result.profile?.photo ?? '';
      globals.isLogin = true;
      return result;
    } catch (ex) {
      globals.isLogin = false;
      return null;
    }
  }

  static Future<void> setLoginByFbOrGg(bool value) async =>
      await GetStorage().write(StorageKey.loginByFbOrGg, value);

  static Future<bool> isLoginByFbOrGg() async =>
      await GetStorage().read(StorageKey.loginByFbOrGg) ?? false;
*/
}

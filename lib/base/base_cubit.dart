import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/app_nearby_service.dart';

class BaseCubit<T> extends Cubit<T> {
  var appNearService = AppNearbyService();
  BaseCubit(super.initialState);
}
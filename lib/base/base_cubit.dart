import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/app_nearby_service.dart';

class BaseCubit<T> extends Cubit<T> {
  var appNearService = AppNearbyService();
  BaseCubit(super.initialState);
}
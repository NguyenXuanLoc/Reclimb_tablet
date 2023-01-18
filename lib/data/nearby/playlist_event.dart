import 'dart:convert';

import '../model/routes_model.dart';

class PlaylistEvent {
  final String playlistType;
  final List<RoutesModel> lRoutes;

  PlaylistEvent(this.playlistType, this.lRoutes);

  Map<String, dynamic> toJson() => {
        "playlistType": playlistType,
        "lRoutes":
            jsonEncode(lRoutes.map((e) => e.toJson()).toList()).toString()
      };
}

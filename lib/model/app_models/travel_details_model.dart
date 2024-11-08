// To parse this JSON data, do
//
//     final travelDetail = travelDetailFromJson(jsonString);

import 'dart:convert';

import 'package:np_com_pandeykushal/model/app_models/travel_model.dart';

List<TravelDetail> travelDetailFromJson(String str) => List<TravelDetail>.from(
    json.decode(str).map((x) => TravelDetail.fromJson(x)));

String travelDetailToJson(List<TravelDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TravelDetail {
  int? id;
  Travel? travel;
  String? groupPhoto;
  String? travelAgenda;

  TravelDetail({
    this.id,
    this.travel,
    this.groupPhoto,
    this.travelAgenda,
  });

  factory TravelDetail.fromJson(Map<String, dynamic> json) => TravelDetail(
        id: json["id"],
        travel: json["travel"] == null ? null : Travel.fromJson(json["travel"]),
        groupPhoto: json["group_photo"],
        travelAgenda: json["travel_agenda"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "travel": travel?.toJson(),
        "group_photo": groupPhoto,
        "travel_agenda": travelAgenda,
      };
}

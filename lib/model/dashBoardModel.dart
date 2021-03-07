import 'dart:convert';

List<DashBoardModel> dashBoardModelFromJson(String str) =>
    List<DashBoardModel>.from(
        json.decode(str).map((x) => DashBoardModel.fromJson(x)));

String dashBoardModelToJson(List<DashBoardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashBoardModel {
  DashBoardModel({
    this.distance,
    this.calorie,
    this.carbonRed,
    this.id,
  });

  int distance;
  double calorie;
  int carbonRed;
  String id;

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
        distance: json["distance"] == null ? null : json["distance"],
        calorie: json["calorie"] == null ? null : json["calorie"].toDouble(),
        carbonRed: json["carbon_red"] == null ? null : json["carbon_red"],
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance == null ? null : distance,
        "calorie": calorie == null ? null : calorie,
        "carbon_red": carbonRed == null ? null : carbonRed,
        "_id": id == null ? null : id,
      };
}

// To parse this JSON data, do
//
//     final stepCountModel = stepCountModelFromJson(jsonString);

import 'dart:convert';

StepCountModel stepCountModelFromJson(String str) => StepCountModel.fromJson(json.decode(str));

String stepCountModelToJson(StepCountModel data) => json.encode(data.toJson());

class StepCountModel {
    StepCountModel({
        this.userStep,
        this.totalStep,
        this.totalCoins,
        this.userCoins,
        this.position,
    });

    int userStep;
    int totalStep;
    int totalCoins;
    int userCoins;
    int position;

    factory StepCountModel.fromJson(Map<String, dynamic> json) => StepCountModel(
        userStep: json["user_step"] == null ? null : json["user_step"],
        totalStep: json["total_step"] == null ? null : json["total_step"],
        totalCoins: json["total_coins"] == null ? null : json["total_coins"],
        userCoins: json["user_coins"] == null ? null : json["user_coins"],
        position: json["position"] == null ? null : json["position"],
    );

    Map<String, dynamic> toJson() => {
        "user_step": userStep == null ? null : userStep,
        "total_step": totalStep == null ? null : totalStep,
        "total_coins": totalCoins == null ? null : totalCoins,
        "user_coins": userCoins == null ? null : userCoins,
        "position": position == null ? null : position,
    };
}

// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
    SearchModel({
        this.name,
        this.img,
        this.coins,
        this.desc,
        this.actPrice,
        this.discPrice,
        this.walkmanPrice,
        this.status,
        this.ratings,
        this.type,
        this.id,
        this.date,
        this.vendorId,
        this.v,
        this.rating,
    });

    String name;
    String img;
    String coins;
    String desc;
    String actPrice;
    String discPrice;
    String walkmanPrice;
    bool status;
    String ratings;
    int type;
    String id;
    DateTime date;
    String vendorId;
    int v;
    int rating;

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        name: json["name"] == null ? null : json["name"],
        img: json["img"] == null ? null : json["img"],
        coins: json["coins"] == null ? null : json["coins"],
        desc: json["desc"] == null ? null : json["desc"],
        actPrice: json["act_price"] == null ? null : json["act_price"],
        discPrice: json["disc_price"] == null ? null : json["disc_price"],
        walkmanPrice: json["walkman_price"] == null ? null : json["walkman_price"],
        status: json["status"] == null ? null : json["status"],
        ratings: json["ratings"] == null ? null : json["ratings"],
        type: json["type"] == null ? null : json["type"],
        id: json["_id"] == null ? null : json["_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
        v: json["__v"] == null ? null : json["__v"],
        rating: json["rating"] == null ? null : json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "img": img == null ? null : img,
        "coins": coins == null ? null : coins,
        "desc": desc == null ? null : desc,
        "act_price": actPrice == null ? null : actPrice,
        "disc_price": discPrice == null ? null : discPrice,
        "walkman_price": walkmanPrice == null ? null : walkmanPrice,
        "status": status == null ? null : status,
        "ratings": ratings == null ? null : ratings,
        "type": type == null ? null : type,
        "_id": id == null ? null : id,
        "date": date == null ? null : date.toIso8601String(),
        "vendor_id": vendorId == null ? null : vendorId,
        "__v": v == null ? null : v,
        "rating": rating == null ? null : rating,
    };
}

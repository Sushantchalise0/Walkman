import 'dart:convert';

BillingModel billingModelFromJson(String str) =>
    BillingModel.fromJson(json.decode(str));

String billingModelToJson(BillingModel data) => json.encode(data.toJson());

class BillingModel {
  BillingModel({
    this.addrs,
  });

  List<Addr> addrs;

  factory BillingModel.fromJson(Map<String, dynamic> json) => BillingModel(
        addrs: json["addrs"] == null
            ? null
            : List<Addr>.from(json["addrs"].map((x) => Addr.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "addrs": addrs == null
            ? null
            : List<dynamic>.from(addrs.map((x) => x.toJson())),
      };
}

class Addr {
  Addr({
    this.fullName,
    this.province,
    this.city,
    this.address,
    this.id,
    this.detail,
    this.phoneNumber,
    this.v,
  });

  String fullName;
  String province;
  String city;
  String address;
  String id;
  String detail;
  int phoneNumber;
  int v;

  factory Addr.fromJson(Map<String, dynamic> json) => Addr(
        fullName: json["fullName"] == null ? null : json["fullName"],
        province: json["province"] == null ? null : json["province"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        id: json["_id"] == null ? null : json["_id"],
        detail: json["detail"] == null ? null : json["detail"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName == null ? null : fullName,
        "province": province == null ? null : province,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "_id": id == null ? null : id,
        "detail": detail == null ? null : detail,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "__v": v == null ? null : v,
      };
}

import 'dart:convert';

LeaderBoardModel leaderBoardModelFromJson(String str) =>
    LeaderBoardModel.fromJson(json.decode(str));

String leaderBoardModelToJson(LeaderBoardModel data) =>
    json.encode(data.toJson());

class LeaderBoardModel {
  LeaderBoardModel({
    this.users,
  });

  List<User> users;

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) =>
      LeaderBoardModel(
        users: json["users"] == null
            ? null
            : List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? null
            : List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.distance,
    this.id,
    this.detail,
  });

  int distance;
  String id;
  Detail detail;

  factory User.fromJson(Map<String, dynamic> json) => User(
        distance: json["distance"] == null ? null : json["distance"],
        id: json["_id"] == null ? null : json["_id"],
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance == null ? null : distance,
        "_id": id == null ? null : id,
        "detail": detail == null ? null : detail.toJson(),
      };
}

class Detail {
  Detail({
    this.userImg,
    this.emailId,
    this.gender,
    this.companyCode,
    this.phoneNumber,
    this.dob,
    this.id,
    this.userName,
    this.v,
  });

  String userImg;
  String emailId;
  String gender;
  String companyCode;
  String phoneNumber;
  DateTime dob;
  String id;
  String userName;
  int v;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        userImg: json["user_img"] == null ? null : json["user_img"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        gender: json["gender"] == null ? null : json["gender"],
        companyCode: json["companyCode"] == null ? null : json["companyCode"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        id: json["_id"] == null ? null : json["_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user_img": userImg == null ? null : userImg,
        "email_id": emailId == null ? null : emailId,
        "gender": gender == null ? null : gender,
        "companyCode": companyCode == null ? null : companyCode,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "dob": dob == null
            ? null
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "_id": id == null ? null : id,
        "user_name": userName == null ? null : userName,
        "__v": v == null ? null : v,
      };
}

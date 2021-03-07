class User {
  String userImg;
  String email;
  String gender;
  String companyCode;
  String phoneNumber;
  DateTime dob;
  String id;
  String name;
  String v;
  
  
  User({
    this.userImg,
    this.email,
    this.gender,
    this.companyCode,
    this.phoneNumber,
    this.dob,
    this.id,
    this.name,
    this.v
  });
  
  factory User.fromJson(Map<String, dynamic> json) =>
      User(
        name: json['user_name'],
        userImg: json['user_img'],
        email: json['email_id'],
        gender: json['gender'],
        companyCode: json['companyCode'],
        phoneNumber: json['phone_number'],
        dob: json['dob'],
        id: json['_id'],
        v: json['__v'],
      );
  
}
import 'package:flutter/material.dart';

class Resturant {
  String imgUrl;
  String name;
  String location;
  String foodAvailabel;
  Resturant({
    @required this.imgUrl,
    @required this.name,
    @required this.location,
    @required this.foodAvailabel,
  });

  Resturant.fromMap(Map snapshot, String documentID,) :
      imgUrl = snapshot['imgUrl'] ?? '',
      name = snapshot['name'] ?? '',
      location= snapshot['location'] ?? '',
      foodAvailabel= snapshot['foodAvailabel'] ?? '';
  toJson(){
    return{
      'imgUrl': imgUrl,
      'name': name,
      'location': location,
      'foodAvailabel': foodAvailabel,
    };
  }
  }
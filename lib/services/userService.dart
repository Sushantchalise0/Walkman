import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:WalkmanMobile/model/usermodel.dart';

class UserServices{
  
  String url;
  List data=[];
  var response;
  var user;
  
  Future<User> getUser() async{
    url='https://peaceful-atoll-49860.herokuapp.com/details';
    response = await http.get(url);
    data= json.decode(response.body);
    user = data.toString();
    
    return user;
  }
}
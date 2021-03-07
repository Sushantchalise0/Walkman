//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:walkman/model/vendor.dart';
//
//class Services{
//  String link= 'https://peaceful-atoll-49860.herokuapp.com/vendors';
//
//  Future getVendors() async{
//    String link= 'https://peaceful-atoll-49860.herokuapp.com/vendors';
//    List<Vendor> vendors;
//    var result= await http.get(Uri.encodeFull(link));
//    print(result.body);
//    if(result.statusCode == 200){
//      var data = json.decode(result.body);
//      var results= data['vendors'] as List;
//      print(results);
//      vendors= results.map<Vendor>((json) => Vendor.fromJson(json)).toList();
//    }
//    print('List Size: ${vendors.length}');
//    return vendors;
//
//
//  }
//
//}

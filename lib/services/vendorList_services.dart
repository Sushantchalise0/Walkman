import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:WalkmanMobile/model/vendor.dart';

class VendorListServices {
  String url;
  List data = [];
  var response;
  
  Iterable<Vendor> vendorList=[];
  
  Future<List<Vendor>> getVendors({String query}) async{
    url='https://peaceful-atoll-49860.herokuapp.com/vendors';
    response = await http.get(url);
    data = json.decode(response.body);
    vendorList = data.map((json) => Vendor.fromJson(json)).toList();
    return vendorList;
  }
}
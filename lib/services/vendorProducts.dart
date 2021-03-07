import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:WalkmanMobile/model/walkdeals.dart';

class VendorProductsServices {
  String url;
  List data = [];
  var response;
  Iterable<Walkmandeals> walkmanDealsList = [];

  Future<List<Walkmandeals>> getWalkmanDeals(String id) async {
    try {
      url =
          'https://peaceful-atoll-49860.herokuapp.com/vendorAllProduct?vendor_id=' +
              id;
      response = await http.get(url);
      data = json.decode(response.body);
      walkmanDealsList =
          data.map((json) => Walkmandeals.fromJson(json)).toList();
      return walkmanDealsList;
    } catch (e) {
      print(e);
    }
  }
}

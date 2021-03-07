import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:WalkmanMobile/model/walkdeals.dart';

class WalkmanDealsServices {
  String url;
  List data=[];
  var response;
  Iterable<Walkmandeals> walkmanDealsList=[];
  
  Future<List<Walkmandeals>> getWalkmanDeals({String query}) async{
    url='http://peaceful-atoll-49860.herokuapp.com/bestdeals';
    response = await http.get(url);
    data= json.decode(response.body);
      walkmanDealsList= data.map((json) => Walkmandeals.fromJson(json)).toList();
    
      if(query !=null){
        walkmanDealsList= walkmanDealsList.where((element) => element.id.toString().contains(query))
            .toList();
      }
      
    return walkmanDealsList;
  }

}
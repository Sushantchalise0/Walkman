import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:WalkmanMobile/model/category.dart';

class CategoryListServices {
  
  String url;
  List data=[];
  var response;
  bool isLoading= true;
  List<Category> categoryList=[];
  
  Future<List<Category>> getCategory() async{
    url='https://peaceful-atoll-49860.herokuapp.com/Categories';
    response = await http.get(url);
    data= json.decode(response.body);
    print(data);
      categoryList= data.map((json) => Category.fromJson(json)).toList();
      isLoading= false;
    
    return categoryList;
  }
}
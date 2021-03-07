import 'dart:convert';
import 'package:WalkmanMobile/model/searchModel.dart';
import 'package:http/http.dart' as http;

class SearchService {
  Future<List<SearchModel>> search(String query) async {
    List<SearchModel> _data;
    try {
      await http
          .get(
              "https://peaceful-atoll-49860.herokuapp.com/productSearch?product_name=" +
                  query)
          .then((value) {
        _data = (json.decode(value.body) as List)
            .map((e) => new SearchModel.fromJson(e))
            .toList();
      });
      return _data;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

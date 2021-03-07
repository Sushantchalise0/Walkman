import 'dart:convert';
import 'package:WalkmanMobile/screens/search/walkman_deals/searchDelegate.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/provider/cartProvider.dart';
import 'package:WalkmanMobile/services/vendorList_services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchAppbar extends StatefulWidget {
  @override
  _SearchAppbarState createState() => _SearchAppbarState();
}

@override
class _SearchAppbarState extends State<SearchAppbar> {
  List<VendorApiSubModel> vendorSearchList = new List();

  getData() {
    APIService.getProductSearch(_searchController.text.trim());
  }

  VendorListServices vendorService = VendorListServices();
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      titleSpacing: 0.0,
      title: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchBody()));
        },
        child: Container(
          height: 35.0,
          margin: EdgeInsets.only(right: 15.0, left: 15),
          padding: EdgeInsets.only(left: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: TextFormField(
            enabled: false,
            controller: _searchController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black54,
                  size: 25,
                ),
                hintText: 'Search'),
          ),
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/cart'),
          child: Badge(
            badgeContent: Text(
              cartProvider.cartList.length.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/shopping-cart.svg",
              height: 25.0,
            ),
            position: BadgePosition.topStart(start: 15, top: 1),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<VendorApiSubModel> vendorSearchList = new List();
  final vendorsearch = [
    "Classic",
    "Green",
    "Classic",
    "Green",
    "Classic",
    "Green",
    "Classic",
    "Green",
    "Classic",
    "Green",
    "Classic",
    "Green",
    "Classic",
    "Green",
    "Classic",
    "Green",
  ];
  final recentsearch = [
    "books",
    "table",
    "laptop",
  ];

  VendorListServices vendorService = VendorListServices();
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    assert(context != null);
    return theme.copyWith(
        textTheme: theme.textTheme.copyWith(
          headline6: theme.textTheme.headline6.copyWith(
            color: theme.primaryTextTheme.headline6.color,
            fontSize: 19.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.8),
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
        ));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          FontAwesomeIcons.solidTimesCircle,
          color: Colors.white60,
          size: 18,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 30.0,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vendorSearchList[index].vendorname),
                Text(vendorSearchList[index].vendoraddress),
              ],
            ),
          ),
        );
      },
      itemCount: vendorSearchList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentsearch
        : vendorsearch.where((p) => p.startsWith(query)).toList();

    return Column(
      children: <Widget>[
        Center(
            child: ListView.builder(
          itemBuilder: (context, index) => ListTile(
            leading: Icon(Icons.shop),
            title: Text(suggestionList[index]),
          ),
          itemCount: suggestionList.length,
        )),
      ],
    );
  }
}

class APIService {
  static Future<VendorApiModel> getProductSearch(String queryParams) async {
    var queryparams = {
      'product_name': 're',
    };
    var uri = Uri.http('${"https://peaceful-atoll-49860.herokuapp.com"}',
        '/productSearch', queryparams);
    final response = await http.get(
      uri,
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return VendorApiModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}

class VendorApiModel {
  List<VendorApiSubModel> rows;

  VendorApiModel({this.rows});

  factory VendorApiModel.fromJson(Map<String, dynamic> parsedjson) {
    var list = parsedjson['rows'] as List;
    List<VendorApiSubModel> subModelList =
        list.map((i) => VendorApiSubModel.fromJson(i)).toList();
    return VendorApiModel(rows: subModelList);
  }
}

class VendorApiSubModel {
  var vendorname = "";
  var vendoraddress = "";

  VendorApiSubModel({
    this.vendorname,
    this.vendoraddress,
  });

  factory VendorApiSubModel.fromJson(Map<String, dynamic> parsedJson) {
    return VendorApiSubModel(
      vendorname: parsedJson['vendor_name'],
      vendoraddress: parsedJson['vendor_address'],
    );
  }
}

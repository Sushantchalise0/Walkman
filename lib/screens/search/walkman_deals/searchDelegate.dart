import 'package:WalkmanMobile/model/searchModel.dart';
import 'package:WalkmanMobile/model/walkdeals.dart';
import 'package:WalkmanMobile/screens/search/walkman_deals/resturant_deals_details.dart';
import 'package:WalkmanMobile/services/searchService.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchBody extends StatefulWidget {
  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading;
  TextEditingController _searchController = TextEditingController();
  SearchService _searchService = SearchService();
  List<SearchModel> _searchResult = [];

  search() async {
    setState(() {
      _isLoading = true;
    });
    await _searchService.search(_searchController.text.trim()).then((value) {
      setState(() {
        _searchResult = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _searchController,
                  onFieldSubmitted: (value) async {
                    if (value.isNotEmpty) {
                      search();
                    }
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Search...",
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search)),
                  ),
                ),
              ),
              SizedBox(height: 6),
              _isLoading == false && _searchResult.length != 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              itemCount: _searchResult.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ResturantDealsDetails(
                                              walkmandeals: Walkmandeals(
                                                  actprice: _searchResult[index]
                                                      .actPrice,
                                                  name:
                                                      _searchResult[index].name,
                                                  img: _searchResult[index].img,
                                                  coins: _searchResult[index]
                                                      .coins,
                                                  desc:
                                                      _searchResult[index].desc,
                                                  discprice:
                                                      _searchResult[index]
                                                          .discPrice,
                                                  status: _searchResult[index]
                                                      .status,
                                                  walkmanprice:
                                                      _searchResult[index]
                                                          .walkmanPrice,
                                                  id: _searchResult[index].id,
                                                  vendorid: _searchResult[index]
                                                      .vendorId,
                                                  ratings: _searchResult[index]
                                                      .ratings,
                                                  type: _searchResult[index]
                                                      .type))));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://peaceful-atoll-49860.herokuapp.com' +
                                                      _searchResult[index]
                                                          .img)),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _searchResult[index].name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                                'By ${_searchResult[index].name}'),
                                            Text('Rs. ' +
                                                _searchResult[index].actPrice)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

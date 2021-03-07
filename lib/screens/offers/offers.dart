// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:walkman/model/walkdeals.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:walkman/services/Walkmandeals_service.dart';

// class Offers extends StatefulWidget {
//   @override
//   _OffersState createState() => _OffersState();
// }

// class _OffersState extends State<Offers> {
//   List data = [];
//   var response;
//   List<Walkmandeals> WalkmanDealsList = [];

//   Future<List<Walkmandeals>> getWalkmanDeals() async {
//     url = 'http://peaceful-atoll-49860.herokuapp.com/bestdeals';
//     response = await http.get(url);
//     data = json.decode(response.body);
//     print(data);
//     WalkmanDealsList = data.map((json) => Walkmandeals.fromJson(json)).toList();
//     print(WalkmanDealsList);

//     return WalkmanDealsList;
//   }
//   // WalkmanDealsServices walkdealListServices = WalkmanDealsServices();

//   @override
//   @override

//   Widget build(BuildContext context) {
//     return Scaffold(
// <<<<<<< HEAD
//         body: FutureBuilder(
//             future: getWalkmanDeals(),
//             builder: (context, snapshot) {
//               List<Walkmandeals> WalkmanDealsList = snapshot.data;
//               print(WalkmanDealsList);
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text(snapshot.error),
//                 );
//               }
//               return snapshot.hasData
//                   ? ListView.builder(
//                       itemCount: WalkmanDealsList.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           child: Card(
//                             child: Column(
//                               children: [
//                                 Text(WalkmanDealsList[index].name),
//                                 Text(WalkmanDealsList[index].desc),
//                                 // Image.network(
//                                 //     'https://peaceful-atoll-49860.herokuapp.com' +
//                                 //         vendorList[index].vendorIc),
//                                 // Text(WalkmandealsList[index].desc.toString()),
//                                 // Text(WalkmandealsList[index].desc),
//                                 // Text(WalkmandealsList[index].ratings),
//                                 // Text(WalkmandealsList[index].walkmanprice),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     )
//                   : LinearProgressIndicator();
//             }));
//       body: FutureBuilder(
//         future: walkmanDealsServices.getWalkmanDeals(),
//         builder: (context, snapshot){
//           print(snapshot);
//           List<Walkmandeals> walkmandealList = snapshot.data;
//           if(snapshot.hasError){
//             return Center(
//               child: Text(snapshot.error),
//             );
//           }
//           return snapshot.hasData
//               ? ListView.builder(
//            itemCount: walkmandealList.length,
//             itemBuilder: (context, index){
//              return Container(
//                child: Card(
//                  child: Column(
//                    children: [
//                      Text(walkmandealList[index].name),
//                      Image.network('https://peaceful-atoll-49860.herokuapp.com'+walkmandealList[index].img),
// //                     Text(vendorList[index].lattitude.toString()),
// //                     Text(vendorList[index].longitude.toString()),
//                    ],
//                  ),
//                ),
//              );
//             },
//           ):LinearProgressIndicator();
//         }
//       )
//     );
// >>>>>>> 82c36e54d26c0f94f322ac0240644dd07011e312
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:WalkmanMobile/model/walkdeals.dart';
import 'package:WalkmanMobile/services/Walkmandeals_service.dart';
import 'package:WalkmanMobile/services/vendorList_services.dart';

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  VendorListServices vendorListServices = VendorListServices();
  WalkmanDealsServices walkmanDealsServices= WalkmanDealsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: walkmanDealsServices.getWalkmanDeals(),
        builder: (context, snapshot){
          print(snapshot);
          List<Walkmandeals> walkmandealList = snapshot.data;
          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error),
            );
          }
          return snapshot.hasData
              ? ListView.builder(
           itemCount: walkmandealList.length,
            itemBuilder: (context, index){
             return Container(
               child: Card(
                 child: Column(
                   children: [
                     Text(walkmandealList[index].name),
                     Image.network('https://peaceful-atoll-49860.herokuapp.com'+walkmandealList[index].img),
//                     Text(vendorList[index].lattitude.toString()),
//                     Text(vendorList[index].longitude.toString()),
                   ],
                 ),
               ),
             );
            },
          ):LinearProgressIndicator();
        }
      )
    );
  }
}

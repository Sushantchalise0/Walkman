
// import 'package:WalkmanApp/model/resturant.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Database {
// // ignore: deprecated_member_use
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Stream<List<Resturant>> getresturants(){
// return _firestore.collection('resturant').snapshots()
//     .map((QuerySnapshot querySnapshot) =>
//     // ignore: deprecated_member_use
//     querySnapshot.documents.map((DocumentSnapshot documentSnapshot)=>
//         Resturant(
//     imgUrl: documentSnapshot.data()['imgUrl'] ?? '',
//     name: documentSnapshot.data()['name'] ?? '',
//     location: documentSnapshot.data()['location'] ?? '',
//     foodAvailabel: documentSnapshot.data()['foodAvailabel'] ?? ''))
//          .toList());
// }
// }
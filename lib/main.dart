import 'package:WalkmanMobile/loaderPage.dart';
import 'package:WalkmanMobile/services/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/provider/cartProvider.dart';
import 'package:WalkmanMobile/provider/notificationProvider.dart';
import 'package:WalkmanMobile/services/Walkmandeals_service.dart';
import 'package:WalkmanMobile/services/categorylist_services.dart';
import 'package:WalkmanMobile/services/userService.dart';
import 'package:WalkmanMobile/services/vendorList_services.dart';
import 'package:WalkmanMobile/util/routes/Router.dart';
import './provider/bottom_navigation_bar.dart';
import './provider/search.dart';
import 'provider/botton_click_provider.dart';
import 'provider/walking/start_walking_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:WalkmanMobile/screens/auth/auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider.value(
          value: SearchProvider(),
        ),
        ChangeNotifierProvider.value(
          value: BottonClickprovider(),
        ),
        ChangeNotifierProvider<StartWalkingProvider>(
          create: (context) => StartWalkingProvider(),
        ),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        FutureProvider(
          create: (BuildContext context) => VendorListServices().getVendors(),
        ),
        FutureProvider(
          create: (BuildContext context) =>
              CategoryListServices().getCategory(),
        ),
        ChangeNotifierProvider(create: (_) => CartService()),
        FutureProvider(
            create: (BuildContext context) =>
                WalkmanDealsServices().getWalkmanDeals()),
        FutureProvider(
            create: (BuildContext context) => UserServices().getUser()),
        ChangeNotifierProvider(
            create: (BuildContext context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF03A63C),
        ),
        title: 'Walkman',
        home: LoaderPage(),
        onGenerateRoute: (settings) => RouterApp.generateRoute(settings),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:health/health.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// enum AppState {
//   DATA_NOT_FETCHED,
//   FETCHING_DATA,
//   DATA_READY,
//   NO_DATA,
//   AUTH_NOT_GRANTED
// }

// class _MyAppState extends State<MyApp> {
//   List<HealthDataPoint> _healthDataList = [];
//   AppState _state = AppState.DATA_NOT_FETCHED;

//   @override
//   void initState() {
//     super.initState();
//   }

  // Future<void> fetchData() async {
  //   /// Get everything from midnight until now
  //   DateTime endDate = DateTime.now();
  //   DateTime startDate = DateTime.now().subtract(Duration(minutes: 360));

  //   HealthFactory health = HealthFactory();

  //   /// Define the types to get.
  //   List<HealthDataType> types = [
  //     HealthDataType.STEPS,
  //   ];

  //   setState(() => _state = AppState.FETCHING_DATA);

  //   /// You MUST request access to the data types before reading them
  //   bool accessWasGranted = await health.requestAuthorization(types);

  //   if (accessWasGranted) {
  //     try {
  //       List<HealthDataPoint> healthData =
  //           await health.getHealthDataFromTypes(startDate, endDate, types);

  //       /// Save all the new data points
  //       _healthDataList.addAll(healthData);
  //     } catch (e) {
  //       print("Caught exception in getHealthDataFromTypes: $e");
  //     }

  //     /// Filter out duplicates
  //     _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

  //     /// Print the results
  //     _healthDataList.forEach((x) => print("Data point: $x"));

  //     /// Update the UI to display the results
  //     setState(() {
  //       _state =
  //           _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
  //     });
  //   } else {
  //     print("Authorization not granted");
  //     setState(() => _state = AppState.DATA_NOT_FETCHED);
  //   }
  // }

//   Widget _contentFetchingData() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//             padding: EdgeInsets.all(20),
//             child: CircularProgressIndicator(
//               strokeWidth: 10,
//             )),
//         Text('Fetching data...')
//       ],
//     );
//   }

//   Widget _contentDataReady() {
//     return ListView.builder(
//         itemCount: _healthDataList.length,
//         itemBuilder: (_, index) {
//           HealthDataPoint p = _healthDataList[index];
//           return ListTile(
//             title: Text("${p.typeString}: ${p.value}"),
//             trailing: Text('${p.unitString}'),
//             subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
//           );
//         });
//   }

//   Widget _contentNoData() {
//     return Text('No Data to show');
//   }

//   Widget _contentNotFetched() {
//     return Text('Press the download button to fetch data');
//   }

//   Widget _authorizationNotGranted() {
//     return Text('''Authorization not given.
//         For Android please check your OAUTH2 client ID is correct in Google Developer Console.
//          For iOS check your permissions in Apple Health.''');
//   }

//   Widget _content() {
//     if (_state == AppState.DATA_READY)
//       return _contentDataReady();
//     else if (_state == AppState.NO_DATA)
//       return _contentNoData();
//     else if (_state == AppState.FETCHING_DATA)
//       return _contentFetchingData();
//     else if (_state == AppState.AUTH_NOT_GRANTED)
//       return _authorizationNotGranted();

//     return _contentNotFetched();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Plugin example app'),
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.file_download),
//                 onPressed: () {
//                   fetchData();
//                 },
//               )
//             ],
//           ),
//           body: Center(
//             child: _content(),
//           )),
//     );
//   }
// }
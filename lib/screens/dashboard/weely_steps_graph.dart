// import 'package:flutter/material.dart';
// import 'package:WalkmanApp/model/weekly_steps_graph.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class WeeklyStepsGraph extends StatelessWidget {
//   final List<WeeklySteps> data;

//   const WeeklyStepsGraph({@required this.data});
//   @override
//   Widget build(BuildContext context) {
//     List<charts.Series<WeeklySteps, String>> seriesWeeklyData = [
//       charts.Series(
//         id: 'Weekly Steps',
//         data: data,
//         domainFn: (WeeklySteps weeklyStep, _) => weeklyStep.weekDay,
//         measureFn: (WeeklySteps weeklyStep, _) => weeklyStep.steps,
//         colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFF2E7D32)),
//       ),
//     ];

//     return Container(
//       height: 510,
//       padding: EdgeInsets.all(4.0),
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Weekly Steps',
//                 style: TextStyle(
//                   color: Theme.of(context).primaryColor,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Column(
//                 children: <Widget>[
//                   Text('Mon, 18 Feb’19'),
//                   Text(
//                     '1542',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
//                 child: charts.BarChart(
//                   seriesWeeklyData,
//                   animate: true,
//                   animationDuration: Duration(seconds: 1),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

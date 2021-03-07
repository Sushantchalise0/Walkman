// import 'package:flutter/material.dart';
// import 'package:WalkmanMobile/model/co2_reduction_graph.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class CO2ReductionGraph extends StatelessWidget {
//   final List<CO2Reduction> data;

//   const CO2ReductionGraph({@required this.data});
//   @override
//   Widget build(BuildContext context) {
//     List<charts.Series<CO2Reduction, int>> seriesCo2ReductionData = [
//       charts.Series<CO2Reduction, int>(
//         id: 'Reduction in CO2',
//         colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFF2E7D32)),
//         domainFn: (CO2Reduction reduction, _) => reduction.weekDay,
//         measureFn: (CO2Reduction reduction, _) => reduction.reduction,
//         data: data,
//       ),
//     ];

//     return Container(
//       height: 550,
//       padding: EdgeInsets.all(4.0),
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'CO2 Reduction',
//                 style: TextStyle(
//                   color: Theme.of(context).primaryColor,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(2.0),
//                 child: charts.LineChart(
//                   seriesCo2ReductionData,
//                   animate: true,
//                   animationDuration: Duration(seconds: 1),
//                   defaultRenderer:
//                       charts.LineRendererConfig(includePoints: true),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

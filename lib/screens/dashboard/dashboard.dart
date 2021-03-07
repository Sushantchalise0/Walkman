import 'package:WalkmanMobile/screens/dashboard/daily_step_Circular_graph.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:toast/toast.dart';
import "package:collection/collection.dart";
import 'package:charts_flutter/flutter.dart' as charts;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;

  List data = [];
  int todayStep = 0;
  double totalCalorie = 0;
  double carbonReduction = 0;

  @override
  void initState() {
    loadUserSteps();
    super.initState();
  }

  List<DataPoint> _dataPoint = [];

  loadUserSteps() async {
    HealthFactory health = HealthFactory();

    List<HealthDataType> types = [HealthDataType.STEPS];

    bool accessWasGranted = await health.requestAuthorization(types);

    if (accessWasGranted) {
      DateTime _startDate = DateTime.now().subtract(Duration(days: 6));
      DateTime _endDate = DateTime.now();
      HealthFactory health = HealthFactory();
      List<HealthDataPoint> _healthDataList = [];

      List<int> _steps = List.filled(7, 0);

      try {
        await health
            .getHealthDataFromTypes(_startDate, _endDate, types)
            .then((value) {
          _healthDataList.addAll(value);
          _healthDataList = HealthFactory.removeDuplicates(_healthDataList);
          if (_healthDataList.length > 0) {
            int finalData = 0;

            var groupByDate = groupBy(
                _healthDataList,
                (HealthDataPoint obj) =>
                    obj.dateFrom.toString().substring(0, 10));
            for (int i = 0; i < 7; i++) {
              groupByDate.values.elementAt(i).asMap().forEach((ii, value) {
                _steps[i] = _steps[i] + value.value;
              });
              _dataPoint.add(DataPoint(
                  xAxis: int.parse(DateTime.now().day.toString()),
                  value: _steps[i].toDouble()));
              finalData = _steps.last;
              setState(() {
                todayStep = finalData;
                totalCalorie = double.parse((0.001 * todayStep).toString());
                carbonReduction = double.parse((35 * todayStep).toString());
              });
            }
          } else {
            Toast.show("Unable to get steps data", context);
          }
        });
      } catch (e) {
        print(e);
        Toast.show(
            "Error getting your steps. Make sure your phone have google fit installed",
            context);
      }
    } else {
      Toast.show("Error getting your steps", context);
    }
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text('DashBoard'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DailyStepGraph(todayStep, "Daily Steps"),
              DailyStepGraph(totalCalorie.toInt(), "Calorie"),
              _dataPoint.length != 0
                  ? Container(
                      height: 300,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.grey),
                          BoxShadow(color: Colors.grey),
                          BoxShadow(color: Colors.grey),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: BezierChart(
                          bezierChartScale: BezierChartScale.CUSTOM,
                          xAxisCustomValues: const [0, 1, 2, 3, 4, 5, 6],
                          series: [
                            BezierLine(data: _dataPoint),
                          ],
                          config: BezierChartConfig(
                            displayLinesXAxis: true,
                            yAxisTextStyle: TextStyle(color: Color(0xFF2E7D32)),
                            xAxisTextStyle: TextStyle(color: Color(0xFF2E7D32)),
                            displayYAxis: true,
                            showDataPoints: true,
                            verticalLineFullHeight: true,
                            verticalIndicatorStrokeWidth: 30.0,
                            verticalIndicatorColor: Colors.black26,
                            showVerticalIndicator: true,
                            xLinesColor: Color(0xFF2E7D32),
                            backgroundColor: Colors.white,
                            snap: false,
                          )),
                    )
                  : SizedBox()

              // DailyStepGraph(carbonReduction.toInt(), "Carbon Reduction"),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class BarChart {
  int count;
  String date;
  Color paintColor;

  BarChart(this.count, this.date, {this.paintColor = Colors.green});
}

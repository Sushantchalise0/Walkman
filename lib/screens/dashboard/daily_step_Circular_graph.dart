import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DailyStepGraph extends StatelessWidget {
  final String title;
  final int todayStep;
  DailyStepGraph(this.todayStep, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey),
          BoxShadow(color: Colors.grey),
          BoxShadow(color: Colors.grey),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 22.0, bottom: 10.0),
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Center(
              child: CircularPercentIndicator(
                radius: 200.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: todayStep < 10000 ? (todayStep / 10000) : (todayStep / 1000000),
                center: Text(
                  todayStep.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.grey.withOpacity(0.3),
                progressColor: Color(0xFF2E7D32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

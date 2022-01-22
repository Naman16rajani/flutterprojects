import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../modal/Transection.dart';

class Chart extends StatefulWidget {
  List<Transaction> transaction;

  Chart(this.transaction);



  @override
  State<StatefulWidget> createState() {
    return ChartState(transaction);
  }
}

class ChartState extends State<Chart> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  List<Transaction> l1;



  List get recentTransaction{
    int i=6;

    return List.generate(7, (index) {
      // var j=i;
      // return transaction.map((e) {
      double ts = 0.0;
      var w = DateTime.now().subtract(Duration(days: i));
      // print("e : ${transaction[j].money}  ${transaction[j].date} $w");
      for (var l = 0; l < l1.length; l++) {
        if (l1[l].date.day == w.day &&
            l1[l].date.month == w.month &&
            l1[l].date.year == w.year) {
          ts = (ts + l1[l].money).toDouble();
        }
      }

      i--;
      return ts;
    });

  }

  // List recentTransaction = txce;
  double get maxList{
    double m = -1.0;
    for (var i = 0; i < l1.length; i++) {
      if (l1[i].money > m) {
        m = l1[i].money;
      }
    }
    return m;
  }


  ChartState(this.l1);

  int now = DateTime.now().weekday - 1;

  int touchedIndex = -1;

  bool isPlaying = false;

  BarChartGroupData makeGroupData(
    int x,
    var y, {
    bool isTouched = false,
    Color barColor = Colors.black,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1.0 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow.shade700, width: 1)
              : const BorderSide(color: Colors.black, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            colors: [Colors.transparent],
            y: (maxList *100)/70,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        var w = DateTime.now().weekday - 1;
// print(w);
        double c = 1.0;

        if (i + 6 - w <= 6) {
          c = recentTransaction[i + 6 - w] + 1;
        }

        switch (i) {
          case 0:
            // print(recentTransaction);
            return makeGroupData(0, c, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, c, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, c, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, c, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, c, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, c, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, c, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;

              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }

              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 500,
      child: Card(
        elevation: 6,
        child: BarChart(
          mainBarData(),
          // BarChartData(
          // ),
          swapAnimationDuration: Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear,
        ),
        // child: Text("chart"),
        // clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
    );
  }
}

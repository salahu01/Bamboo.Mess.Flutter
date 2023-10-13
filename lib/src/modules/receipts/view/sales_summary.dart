import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:intl/intl.dart';

class SalesSummary extends StatefulWidget {
  const SalesSummary({super.key});

  @override
  State<SalesSummary> createState() => _SalesSummaryState();
}

class _SalesSummaryState extends State<SalesSummary> {
  DateTime fromTimeController = DateTime.now();

  static String getFormatedString({required DateTime date, String? formate}) {
    return DateFormat(formate ?? 'dd-MM-yyyy').format(date);
  }

  TextEditingController? pickdatecontroller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary.value,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("    Select Date", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              child: Container(
                                height: 70,
                                width: 400,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2, offset: Offset.zero)],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 380,
                                      margin: const EdgeInsets.only(left: 4),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: getFormatedString(date: fromTimeController),
                                            hintStyle: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
                                            border: InputBorder.none),
                                        onTap: () async {
                                          DateTime? date = DateTime(2023);
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2023), lastDate: DateTime(2200));
                                          fromTimeController = date!;
                                          log(
                                            getFormatedString(date: fromTimeController),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      totalacount("Refunds", "0.00"),
                      totalacount("Discount", "0.00"),
                      totalacount("Grand Total", "52000.00"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(flex: 5, child: SalesSummaryLineChart())
        ],
      ),
    );
  }

  totalacount(String text, String amount) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          children: [
            Text(text.toString(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black)),
            Text("₹ $amount", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800, color: primary.value))
          ],
        ),
      ),
    );
  }
}

class SalesSummaryLineChart extends StatefulWidget {
  const SalesSummaryLineChart({
    super.key,
    Color? gradientColor1,
    Color? gradientColor2,
    Color? gradientColor3,
    Color? indicatorStrokeColor,
  })  : gradientColor1 = gradientColor1 ?? Colors.blue,
        gradientColor2 = gradientColor2 ?? Colors.pink,
        gradientColor3 = gradientColor3 ?? Colors.red,
        indicatorStrokeColor = indicatorStrokeColor ?? Colors.amber;

  final Color gradientColor1;
  final Color gradientColor2;
  final Color gradientColor3;
  final Color indicatorStrokeColor;

  @override
  State<SalesSummaryLineChart> createState() => _SalesSummaryLineChartState();
}

class _SalesSummaryLineChartState extends State<SalesSummaryLineChart> {
  List<int> showingTooltipOnSpots = [1, 3, 5];

  List<FlSpot> get allSpots => const [
        FlSpot(0, 1),
        FlSpot(1, 2),
        FlSpot(2, 1.5),
        FlSpot(3, 3),
        FlSpot(4, 3.5),
        FlSpot(5, 5),
        FlSpot(6, 8),
        FlSpot(7, 7.6),
        FlSpot(8, 8),
        // FlSpot(9, 3),
        // FlSpot(10, 3.5),
        // FlSpot(11, 5),
        // FlSpot(12, 8),
        // FlSpot(13, 7.6),
        // FlSpot(14, 8),
      ];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: primary.value,
      fontSize: 8 * chartWidth / 750,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '07:00';
        break;
      case 1:
        text = '09:30';
        break;
      case 2:
        text = '11:30';
        break;
      case 3:
        text = '01:30';
        break;
      case 4:
        text = '03:30';
        break;
      case 5:
        text = '05:30';
        break;
      case 6:
        text = '07:30';
        break;
      case 7:
        text = '09:30';
        break;
      case 8:
        text = '11:30';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 4,
        shadow: const Shadow(
          blurRadius: 8,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              widget.gradientColor1.withOpacity(0.4),
              widget.gradientColor2.withOpacity(0.4),
              widget.gradientColor3.withOpacity(0.4),
            ],
          ),
        ),
        // dotData: const FlDotData(show: false),
        gradient: LinearGradient(
          colors: [
            widget.gradientColor1,
            widget.gradientColor2,
            widget.gradientColor3,
          ],
          stops: const [0.1, 0.4, 0.9],
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: SizedBox(
              width: double.infinity,
              height: 700,
              child: AspectRatio(
                aspectRatio: 10,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return LineChart(
                      LineChartData(
                        showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                          return ShowingTooltipIndicators([
                            LineBarSpot(
                              tooltipsOnBar,
                              lineBarsData.indexOf(tooltipsOnBar),
                              tooltipsOnBar.spots[index],
                            ),
                          ]);
                        }).toList(),
                        lineTouchData: LineTouchData(
                          enabled: true,
                          handleBuiltInTouches: false,
                          touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                            if (response == null || response.lineBarSpots == null) {
                              return;
                            }
                            if (event is FlTapUpEvent) {
                              final spotIndex = response.lineBarSpots!.first.spotIndex;
                              setState(() {
                                if (showingTooltipOnSpots.contains(spotIndex)) {
                                  showingTooltipOnSpots.remove(spotIndex);
                                } else {
                                  showingTooltipOnSpots.add(spotIndex);
                                }
                              });
                            }
                          },
                          mouseCursorResolver: (FlTouchEvent event, LineTouchResponse? response) {
                            if (response == null || response.lineBarSpots == null) {
                              return SystemMouseCursors.basic;
                            }
                            return SystemMouseCursors.click;
                          },
                          getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                            return spotIndexes.map((index) {
                              return TouchedSpotIndicatorData(
                                const FlLine(
                                  color: Colors.pink,
                                ),
                                FlDotData(
                                  show: true,
                                  getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                    radius: 8,
                                    color: lerpGradient(
                                      barData.gradient!.colors,
                                      barData.gradient!.stops!,
                                      percent / 100,
                                    ),
                                    strokeWidth: 2,
                                    // strokeColor: widget.indicatorStrokeColor,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.pink,
                            tooltipRoundedRadius: 8,
                            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                              return lineBarsSpot.map((lineBarSpot) {
                                return LineTooltipItem(
                                  lineBarSpot.y.toString(),
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        lineBarsData: lineBarsData,
                        // minY: 0,
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              // interval: 1,
                              getTitlesWidget: (value, meta) {
                                return bottomTitleWidgets(
                                  value,
                                  meta  ,
                                  1500,
                                );
                              },
                              reservedSize: 60,
                            ),
                          ),
                          rightTitles: const AxisTitles(
                            axisNameWidget: Text(''),
                            sideTitles: SideTitles(
                              showTitles: false,
                              reservedSize: 0,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            axisNameWidget: Text(
                              'Sales Summary',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                            ),
                            axisNameSize: 25,
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 0,
                            ),
                          ),
                        ),
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// / Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}

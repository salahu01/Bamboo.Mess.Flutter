import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:freelance/src/core/extensions/date_time.extension.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/theme/app_colors.dart';

class SalesSummary extends StatefulWidget {
  const SalesSummary({super.key, required this.reciepts});
  final List<List<RecieptModel>> reciepts;

  @override
  State<SalesSummary> createState() => _SalesSummaryState();
}

class _SalesSummaryState extends State<SalesSummary> {
  final summuries = ['Year', 'Month', 'Day'];
  String selectedSummury = 'Year';
  int selectedDataIndex = 0;
  List<List<RecieptModel>> monthlyReciepts = [];
  List<List<RecieptModel>> yearlyReciepts = [];
  List<List<RecieptModel>> selectedData = [];
  @override
  void initState() {
    for (var e in widget.reciepts) {
      final yearlyIndex = yearlyReciepts.indexWhere((_) => '${_.first.date?.year}' == '${e.first.date?.year}');
      yearlyIndex == -1 ? yearlyReciepts = [...yearlyReciepts, e] : yearlyReciepts[yearlyIndex] = [...yearlyReciepts[yearlyIndex], ...e];
      final monthIndex = monthlyReciepts.indexWhere((_) => '${_.first.date?.year}-${_.first.date?.month}' == '${e.first.date?.year}-${e.first.date?.month}');
      monthIndex == -1 ? monthlyReciepts = [...monthlyReciepts, e] : monthlyReciepts[monthIndex] = [...monthlyReciepts[monthIndex], ...e];
    }
    _updateSelectedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary.value,
      ),
      body: Visibility(
        visible: widget.reciepts.isNotEmpty,
        replacement: const Center(child: Text('No Reciepts', style: TextStyle(fontSize: 30))),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                    value: selectedSummury,
                    items: summuries.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.black, fontSize: 32)))).toList(),
                    onChanged: (v) {
                      setState(() {
                        selectedSummury = v!;
                        selectedDataIndex = 0;
                        _updateSelectedData();
                      });
                    },
                  ),
                  DropdownButton(
                    value: selectedDataIndex,
                    items: dropdownItems(),
                    onChanged: (v) {
                      setState(() {
                        selectedDataIndex = v!;
                        _updateSelectedData();
                      });
                    },
                  ),
                  totalacount("Grand Total", "${selectedData[selectedDataIndex].fold(0.0, (a, b) => (a) + (b.totalAmount ?? 0))}"),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SfCartesianChart(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  series: <ChartSeries>[
                    LineSeries<List<RecieptModel>, int>(
                      dataSource: monthlyReciepts,
                      xValueMapper: (datas, _) => datas.first.date?.day ?? 0,
                      yValueMapper: (datas, _) => datas.fold(0, (a, b) => (a ?? 0) + (b.totalAmount ?? 0)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateSelectedData() {
    selectedData = (selectedSummury == 'Year'
        ? yearlyReciepts
        : selectedSummury == 'Day'
            ? widget.reciepts
            : monthlyReciepts);
  }

  Widget totalacount(String text, String amount) {
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

  List<DropdownMenuItem> dropdownItems() {
    return List.generate(selectedData.length, (i) {
      var label = selectedSummury == 'Year'
          ? '${selectedData[i].first.date?.year}'
          : selectedSummury == 'Day'
              ? '${selectedData[i].first.date?.order}'
              : '${selectedData[i].first.date?.year} - ${selectedData[i].first.date?.monthToString}';
      return DropdownMenuItem(value: i, child: Text(label, style: const TextStyle(color: Colors.black, fontSize: 32)));
    });
  }

  @override
  void dispose() {
    selectedData.clear();
    yearlyReciepts.clear();
    monthlyReciepts.clear();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:freelance/src/core/extensions/date_time.extension.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesSummary extends StatefulWidget {
  const SalesSummary({super.key, required this.reciepts});
  final List<List<RecieptModel>> reciepts;

  @override
  State<SalesSummary> createState() => _SalesSummaryState();
}

class _SalesSummaryState extends State<SalesSummary> {
  TextEditingController? pickdatecontroller;
  final summuries = ['Year', 'Month'];
  String selectedSummury = 'Year';
  int selectedDataIndex = 0;
  List<List<RecieptModel>> monthlyReciepts = [];
  // List<List<RecieptModel>> weeklyReciepts = [];
  List<List<RecieptModel>> yearlyReciepts = [];

  @override
  void initState() {
    for (var e in widget.reciepts) {
      final yearlyIndex = monthlyReciepts.indexWhere((_) => '${_.first.date?.year}' == '${e.first.date?.year}');
      yearlyIndex == -1 ? yearlyReciepts.add(e) : yearlyReciepts[yearlyIndex].addAll(e);
      final monthIndex = monthlyReciepts.indexWhere((_) => '${_.first.date?.year}-${_.first.date?.month}' == '${e.first.date?.year}-${e.first.date?.month}');
      monthIndex == -1 ? monthlyReciepts.add(e) : monthlyReciepts[monthIndex].addAll(e);
      // final weekIndex =
      //     weeklyReciepts.indexWhere((_) => '${_.first.date?.year}-${_.first.date?.month}-${_.first.date?.weekday}' == '${e.first.date?.year}-${e.first.date?.month}-${e.first.date?.weekday}');
      // weekIndex == -1 ? weeklyReciepts.add(e) : weeklyReciepts[weekIndex].addAll(e);
    }
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
                    onChanged: (v) => setState(() => selectedSummury = v!),
                  ),
                  DropdownButton(
                    value: selectedDataIndex,
                    items: dropdownItems(),
                    onChanged: (v) => setState(() => selectedDataIndex = v!),
                  ),
                  totalacount("Grand Total", "${monthlyReciepts.first.fold(0.0, (a, b) => (a) + (b.totalAmount ?? 0))}"),
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
    final selectedData = (selectedSummury == 'Year' ? yearlyReciepts : monthlyReciepts);
    return List.generate(selectedData.length, (i) {
      var label = selectedSummury == 'Year' ? '${selectedData[i].first.date?.year}' : '${selectedData[i].first.date?.year} - ${selectedData[i].first.date?.monthToString}';
      return DropdownMenuItem(value: i, child: Text(label, style: const TextStyle(color: Colors.black, fontSize: 32)));
    });
  }
}

/// Example of a simple line chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<int> data;
  SimpleLineChart(this.data);

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(prepData(data), animate: true);
  }

  List<charts.Series<MapEntry<int, int>, int>> prepData(List<int> data) => [
        new charts.Series<MapEntry<int, int>, int>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (MapEntry<int, int> datum, _) => datum.key,
          measureFn: (MapEntry<int, int> datum, _) => datum.value,
          data: data.asMap().entries.toList(),
        )
      ];
}

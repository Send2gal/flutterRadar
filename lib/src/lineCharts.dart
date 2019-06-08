/// Example of a simple line chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<List<double>> data;
  SimpleLineChart(this.data);

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(prepData(data), animate: false);
  }

  List<charts.Series<MapEntry<int, double>, int>> prepData(
          List<List<double>> data) =>
      data
          .map((_data) => new charts.Series<MapEntry<int, double>, int>(
                id: 'Radar-${data.indexOf(_data)}',
                displayName: 'Test Radar-${data.indexOf(_data)}',
                overlaySeries: true,
                // colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                domainFn: (MapEntry<int, double> datum, _) => datum.key,
                measureFn: (MapEntry<int, double> datum, _) => datum.value,
                data: _data.asMap().entries.toList(),
              ))
          .toList();
}

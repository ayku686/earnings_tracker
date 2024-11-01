import 'package:expense_tracker/models/earnings_data.dart';
import 'package:fl_chart/fl_chart.dart';

class DoubleLineChart{
  List<EarningsData> data;
  DoubleLineChart(this.data);

  List<FlSpot> getActualEpsSpots() {
    return data.map((entry) {
      final date = DateTime.parse(entry.priceDate);
      return FlSpot(date.millisecondsSinceEpoch.toDouble(), entry.actualEps);
    }).toList();
  }

  List<FlSpot> getEstimatedEpsSpots() {
    return data.map((entry) {
      final date = DateTime.parse(entry.priceDate);
      return FlSpot(date.millisecondsSinceEpoch.toDouble(), entry.estimatedEps);
    }).toList();
  }
}

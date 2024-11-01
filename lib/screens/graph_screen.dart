import 'package:expense_tracker/bloc/bloc_events.dart';
import 'package:expense_tracker/models/earnings_data.dart';
import 'package:expense_tracker/screens/transcript_screen.dart';
import 'package:expense_tracker/utilities/double_line_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../bloc/bloc_states.dart';
import '../bloc/earnings_bloc.dart';

class GraphScreen extends StatefulWidget {
  final String ticker;
  const GraphScreen({super.key,required this.ticker});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}


class _GraphScreenState extends State<GraphScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ticker = widget.ticker;
    context.read<EarningsBloc>().add(FetchEarningsData(ticker));  // Re-fetch data if needed
  }
  @override
  Widget build(BuildContext context) {
    final startDate = DateTime(2023, 1, 1);
    final endDate = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings Graph')),
      body: BlocBuilder<EarningsBloc, EarningsState>(
        builder: (context, state) {
          if (state is EarningsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EarningsLoaded) {
            List<EarningsData> data = state.data;
            DoubleLineChart doubleLineChart = DoubleLineChart(data);
            return Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Column(
                children: [
                  // Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LegendItem(color: Colors.blue, label: 'Actual EPS'),
                      SizedBox(width: 10.w),
                      const LegendItem(color: Colors.green, label: 'Estimated EPS'),
                      SizedBox(width: 10.w),
                    ],
                  ),
                  // Chart
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: SizedBox(
                        width: 1000,
                        child: LineChart(
                          LineChartData(
                            minX: startDate.millisecondsSinceEpoch.toDouble(),
                            maxX: endDate.millisecondsSinceEpoch.toDouble(),
                            minY: 0,
                            maxY: 10,
                            gridData: const FlGridData(show: true),
                            titlesData: FlTitlesData(
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 90 * 24 * 3600 * 1000,
                                  getTitlesWidget: (value, meta) {
                                    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                                    return Text(
                                      DateFormat('yyyy-MM').format(date),
                                      style:  TextStyle(fontSize: 10.sp),
                                    );
                                  },
                                  reservedSize: 40.sp,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: true),
                            lineBarsData: [
                              LineChartBarData(
                                spots: doubleLineChart.getActualEpsSpots(),
                                isCurved: true,
                                color: Colors.blue,
                                barWidth: 2.sp,
                                belowBarData: BarAreaData(show: false),
                                dotData: const FlDotData(show: true),
                              ),
                              LineChartBarData(
                                spots: doubleLineChart.getEstimatedEpsSpots(),
                                isCurved: true,
                                color: Colors.green,
                                barWidth: 2.sp,
                                belowBarData: BarAreaData(show: false),
                                dotData: const FlDotData(show: true),
                              ),
                            ],
                            lineTouchData: LineTouchData(
                              touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
                                if (touchResponse != null &&
                                    event is! PointerExitEvent &&
                                    event is! PointerUpEvent) {
                                  final touchedSpot = touchResponse.lineBarSpots?.first;
                                  if (touchedSpot != null) {
                                    final date = DateTime.fromMillisecondsSinceEpoch(touchedSpot.x.toInt());
                                    _onNodeTapped(context, date,data.first.ticker);
                                  }
                                }
                              },
                              handleBuiltInTouches: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data '));
          }
        },
      ),
    );
  }
  void _onNodeTapped(BuildContext context,DateTime date, String ticker) async {
    int year = date.year;
    int quarter = ((date.month - 1) ~/ 3) + 1;
    context.read<EarningsBloc>().add(FetchTranscript(ticker,quarter,year));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TranscriptScreen()),
    );
  }
}



class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}

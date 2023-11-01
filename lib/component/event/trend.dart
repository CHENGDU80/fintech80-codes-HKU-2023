import 'package:apollo/data/colors.dart';
import 'package:apollo/object/graph.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EventTrend extends StatelessWidget {
  final List<int> trend;
  const EventTrend({super.key, required this.trend});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Trend",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        SfCartesianChart(
          plotAreaBorderColor: Colors.transparent,
          crosshairBehavior: CrosshairBehavior(
              enable: true, activationMode: ActivationMode.longPress),
          primaryXAxis: DateTimeAxis(
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(),
          tooltipBehavior: TooltipBehavior(enable: true, header: "Price"),
          series: <ChartSeries>[
            AreaSeries<GraphData, DateTime>(
              dataSource: List.generate(
                trend.length,
                (index) => GraphData(
                  DateTime(index),
                  trend[index].toDouble(),
                ),
              ),
              xValueMapper: (GraphData sales, _) => sales.time,
              yValueMapper: (GraphData sales, _) => sales.price,
              enableTooltip: true,
              borderDrawMode: BorderDrawMode.top,
              borderColor: const Color(0xff4399e1),
              borderWidth: 1,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [MyColors.light.withOpacity(0.5), Colors.transparent],
                stops: const [0.5, 1],
              ),
            )
          ],
        ),
      ],
    );
  }
}

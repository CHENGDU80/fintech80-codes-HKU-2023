import 'package:apollo/object/graph.dart';
import 'package:intl/intl.dart';

import 'package:apollo/component/header_info.dart';
import 'package:apollo/component/home_company.dart';
import 'package:apollo/component/home_news.dart';
import 'package:apollo/controller/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  final String stockName = "HII";

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat.compact(locale: "en_US");
    return Row(
      children: [
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              Consumer<StockProvider>(
                builder: (context, value, child) {
                  return HeadInfo(
                      name: value.currentStock,
                      price: f
                          .format((value.data["open"] ?? 0 as double).toInt()));
                },
              ),
              const Expanded(
                child: MyGraph(),
              ),
              Container(
                padding: const EdgeInsets.only(left: 40, right: 20),
                height: 80,
                child: Consumer<StockProvider>(
                  builder: (BuildContext context, StockProvider stockProvider,
                      Widget? child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberData(
                            title: "Market Cap",
                            data: f.format(
                                (stockProvider.data["marketCap"] ?? 0 as double)
                                    .toInt())),
                        NumberData(
                            title: "Open",
                            data: f.format(
                                (stockProvider.data["open"] ?? 0 as double)
                                    .toInt())),
                        NumberData(
                            title: "Close",
                            data: f.format(
                                (stockProvider.data["close"] ?? 0 as double)
                                    .toInt())),
                        NumberData(
                            title: "Day High",
                            data: f.format(
                                (stockProvider.data["dayHigh"] ?? 0 as double)
                                    .toInt())),
                        NumberData(
                            title: "Day Low",
                            data: f.format(
                                (stockProvider.data["dayLow"] ?? 0 as double)
                                    .toInt())),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 400,
          child: Column(
            children: [
              HomeNewsView(),
              CompanyView(),
            ],
          ),
        )
      ],
    );
  }
}

class MyGraph extends StatelessWidget {
  const MyGraph({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StockProvider>(
      builder: (context, value, child) {
        return SfCartesianChart(
          plotAreaBorderColor: Colors.transparent,
          crosshairBehavior: CrosshairBehavior(
              enable: true, activationMode: ActivationMode.longPress),
          primaryXAxis: DateTimeAxis(
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(),
          tooltipBehavior:
              TooltipBehavior(enable: true, duration: 1, header: "Price"),
          series: <ChartSeries>[
            AreaSeries<GraphData, DateTime>(
              dataSource: value.predictedDataUp,
              xValueMapper: (GraphData sales, _) => sales.time,
              yValueMapper: (GraphData sales, _) => sales.price,
              borderWidth: 2,
              borderColor: Colors.green,
              color: Colors.green.shade100.withOpacity(0.6),
              dashArray: const <double>[15, 3, 3, 3],
            ),
            AreaSeries<GraphData, DateTime>(
              dataSource: value.predictedDataMid,
              xValueMapper: (GraphData sales, _) => sales.time,
              yValueMapper: (GraphData sales, _) => sales.price,
              borderWidth: 2,
              borderColor: const Color(0xff3961f6),
              color: Colors.red.shade100,
              dashArray: const <double>[15, 3, 3, 3],
            ),
            AreaSeries<GraphData, DateTime>(
              dataSource: value.predictedDataLow,
              xValueMapper: (GraphData sales, _) => sales.time,
              yValueMapper: (GraphData sales, _) => sales.price,
              borderWidth: 2,
              borderColor: Colors.red.withOpacity(0.6),
              color: Colors.white,
              dashArray: const <double>[15, 3, 3, 3],
            ),
            SplineAreaSeries<GraphData, DateTime>(
              dataSource: value.chartData,
              xValueMapper: (GraphData sales, _) => sales.time,
              yValueMapper: (GraphData sales, _) => sales.price,
              borderDrawMode: BorderDrawMode.top,
              borderColor: const Color(0xff3961f6),
              borderWidth: 3,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xff3961f6).withOpacity(0.5),
                  Colors.transparent
                ],
                stops: const [0, 1],
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:apollo/component/event/news.dart';
import 'package:apollo/controller/home.dart';
import 'package:apollo/controller/my_controller.dart';
import 'package:apollo/data/colors.dart';
import 'package:apollo/object/event.dart';
import 'package:apollo/object/news.dart';
import 'package:apollo/screens/graph.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class ImpactScreen extends StatelessWidget {
  const ImpactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<HomeProv>();
    final stockProvider = context.watch<StockProvider>();
    if (prov.events.isEmpty) {
      return const Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      );
    }
    final data = prov.events[prov.selected]!.data;
    return prov.notifCount == 1
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text(
                  "Our AI Model has detected new news source...",
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Headline(data: data, count: prov.notifCount),
                  HeaderInfo(summary: data.summary),
                  const SizedBox(height: 30),
                  const MyTitle(title: "Prediction"),
                  Row(
                    children: [
                      for (int i = 0; i < data.stocks.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              prov.stock_select(i);
                              stockProvider.setCurrentStock(data.stocks[i]);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: i == prov.stockSelected
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            child: Text(
                              data.stocks[i],
                              style: TextStyle(
                                color: i == prov.stockSelected
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 30),
                          height: 500,
                          child: const Row(
                            children: [
                              Expanded(
                                child: MyGraph(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 410,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const MyTitle(title: "Model rating"),
                            const Text(
                                "Based on ChatGPT and our cutting edge price detection algorithm rating based on past week data"),
                            Speedometer(
                                value: data.prediction["recommendation"] ?? 0),
                            SizedBox(
                              width: 300,
                              height: 200,
                              child: SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                primaryXAxis: CategoryAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  majorTickLines: const MajorTickLines(size: 0),
                                ),
                                series: _getTrackerBarSeries(data.prediction),
                                tooltipBehavior: TooltipBehavior(enable: true),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Text(
                    'Key Stats',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < 4; i++)
                          ItemStats(
                              title: KeyStats.titles[i],
                              t: data.stats[KeyStats.key[i]]!)
                      ]),
                  const SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < 4; i++)
                          ItemStats(
                              title: KeyStats.titles[i + 4],
                              t: data.stats[KeyStats.key[i + 4]]!)
                      ]),
                  const SizedBox(height: 30),
                  const MyTitle(title: "News Sources"),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.news['data']!.length,
                        itemBuilder: (context, index) {
                          return NewsSource(
                            imagePath: data.news['data']![index]['image'],
                            headline: data.news['data']![index]['headline'],
                            source: data.news['data']![index]['source'],
                          );
                        }),
                  ),
                  const MyTitle(title: "Relevant Events"),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.relevant.length,
                        itemBuilder: (context, index) {
                          return RelevantEvent(
                            imagePath: data.relevant[index]['image'],
                            headline: data.relevant[index]['headline'],
                          );
                        }),
                  ),
                  const MyTitle(title: "Technicals"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Speedometer(
                          value: data.prediction["recommendation"] ?? 0),
                      Speedometer(value: data.prediction["technical"] ?? 0),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}

class Speedometer extends StatelessWidget {
  final double value;
  const Speedometer({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const double graphDepth = 80;
    return SizedBox(
      width: 410,
      height: 260,
      child: Stack(children: [
        const Positioned(
          top: 210 - graphDepth,
          left: 10,
          child: Text(
            "Strong sell",
            style: TextStyle(fontSize: 15),
          ),
        ),
        const Positioned(
          top: 150 - graphDepth,
          left: 80,
          child: Text(
            "Sell",
            style: TextStyle(fontSize: 15),
          ),
        ),
        const Positioned(
          top: 110 - graphDepth,
          left: 190,
          child: Text(
            "Hold",
            style: TextStyle(fontSize: 15),
          ),
        ),
        const Positioned(
          top: 150 - graphDepth,
          left: 310,
          child: Text(
            "Buy",
            style: TextStyle(fontSize: 15),
          ),
        ),
        const Positioned(
          top: 210 - graphDepth,
          right: 0,
          child: Text(
            "Strong buy",
            style: TextStyle(fontSize: 15),
          ),
        ),
        const Positioned(
          top: 300 - graphDepth,
          left: 195,
          child: Text(
            "BUY",
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),
        ),
        Positioned(
          top: 150 - graphDepth,
          left: 85,
          child: SizedBox(
            width: 250,
            height: 250,
            child: RotatedBox(
              quarterTurns: 3,
              child: GradientCircularProgressIndicator(
                stroke: 10,
                progress: value * 0.5,
                gradient: const LinearGradient(colors: [
                  Colors.blue,
                  Colors.purple,
                ]),
              ),
            ),
          ),
        ),
        Positioned(
          top: 160 - graphDepth,
          left: 95,
          child: SizedBox(
            width: 230,
            height: 230,
            child: RotatedBox(
              quarterTurns: 3,
              child: GradientCircularProgressIndicator(
                stroke: 10,
                progress: value * 0.5,
                gradient: LinearGradient(colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.purple.withOpacity(0.3),
                ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

List<BarSeries<ChartSampleData, String>> _getTrackerBarSeries(
    Map<String, double> sd) {
  return <BarSeries<ChartSampleData, String>>[
    BarSeries<ChartSampleData, String>(
      dataSource: <ChartSampleData>[
        ChartSampleData('Strong Buy', sd["strongbuy"] ?? 0),
        ChartSampleData('Buy', sd["buy"] ?? 0),
        ChartSampleData('Hold', sd["hold"] ?? 0),
        ChartSampleData('Sell', sd["sell"] ?? 0),
        ChartSampleData('Strong sell', sd["strongsell"] ?? 0),
      ],
      borderRadius: BorderRadius.circular(15),
      trackColor: const Color.fromRGBO(198, 201, 207, 1),
      isTrackVisible: true,
      dataLabelSettings: const DataLabelSettings(
          isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      yValueMapper: (ChartSampleData sales, _) => sales.y,
    ),
  ];
}

class ChartSampleData {
  String x;
  double y;
  ChartSampleData(this.x, this.y);
}

class RelevantEvent extends StatelessWidget {
  final String imagePath;
  final String headline;
  const RelevantEvent(
      {super.key, required this.imagePath, required this.headline});

  Future<String?> getIcon() async {
    final response = await http.get(
      Uri.parse("http://3.1.30.54:8080/get_image?path=relevant/$imagePath"),
    );
    if (response.statusCode != 200) {
      return null;
    }
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: InkWell(
        hoverColor: MyColors.primary,
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // prov.select(index);
        },
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: MyColors.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: getIcon(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Container(
                        height: 140,
                        width: 300 * 1.618,
                        color: Colors.grey[300],
                      );
                    }
                    final image = snapshot.data!;
                    return Container(
                      height: 140,
                      width: 300 * 1.618,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  headline,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsSource extends StatelessWidget {
  final String imagePath;
  final String headline;
  final String source;
  const NewsSource(
      {super.key,
      required this.imagePath,
      required this.headline,
      required this.source});

  Future<String?> getIcon() async {
    final response = await http.get(
      Uri.parse("http://3.1.30.54:8080/get_image?path=news/$imagePath"),
    );
    if (response.statusCode != 200) {
      return null;
    }
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: InkWell(
        hoverColor: MyColors.primary,
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // prov.select(index  );
        },
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: MyColors.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: getIcon(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Container(
                        height: 140,
                        width: 300 * 1.618,
                        color: Colors.grey[300],
                      );
                    }
                    final image = snapshot.data!;
                    return Container(
                      height: 140,
                      width: 300 * 1.618,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  headline,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
                EventNewsSource(
                  news: source,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTitle extends StatelessWidget {
  final String title;
  const MyTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 35,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        height: 0,
      ),
    );
  }
}

class ItemStats extends StatelessWidget {
  final String t;
  final String title;
  const ItemStats({super.key, required this.t, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 18,
              fontFamily: 'Inter',
              height: 0,
            ),
          ),
          Text(
            t,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class HeaderInfo extends StatelessWidget {
  final String summary;
  const HeaderInfo({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final arr = summary.split("-*-");
    int which = -1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const GradientText(
          'AI generated summary:',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
        ),
        const SizedBox(height: 10),
        const SizedBox(height: 10),
        for (int i = 0; i < arr.length; i++)
          SizedBox(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                Text(arr[i]),
              ],
            ),
          ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class Headline extends StatelessWidget {
  final int count;
  const Headline({super.key, required this.data, required this.count});

  final EventData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120 * 1.618,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              image: CachedNetworkImageProvider(data.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 696,
          height: 102,
          child: Text(
            data.headline,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Badge(
          label: count != 0 ? Text(count.toString()) : null,
          child: const Icon(
            Icons.notifications,
            color: Colors.black87,
            size: 35,
          ),
        )
      ],
    );
  }
}

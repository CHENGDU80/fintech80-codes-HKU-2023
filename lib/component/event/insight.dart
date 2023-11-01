import 'package:apollo/component/event/news.dart';
import 'package:apollo/component/event/trend.dart';
import 'package:apollo/controller/home.dart';
import 'package:apollo/data/colors.dart';
import 'package:apollo/screens/impact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventInsight extends StatelessWidget {
  final TabController tb;
  const EventInsight({super.key, required this.tb});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<HomeProv>();
    if (prov.events.isEmpty || prov.events[prov.selected] == null) {
      return const Center(
        child: SizedBox.square(
          dimension: 50,
          child: CircularProgressIndicator(),
        ),
      );
    }
    final data = prov.events[prov.selected]!.data;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(24),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              ListView(
                children: [
                  Text(
                    data.headline,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => MyGradient.main.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: const GradientText(
                      'AI generated summary:',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.purple]),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.summary,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: EventTrend(trend: data.trend)),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "News Source",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ...List.generate(
                              data.news.length,
                              (index) => EventNewsSource(
                                  news: data.news['data']![index]['source']!),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              // InkWell(
              //   borderRadius: BorderRadius.circular(100),
              //   onTap: () {
              //     tb.animateTo(1);
              //     context.read<TabProv>().notify();
              //   },
              //   child: Container(
              //     height: 50,
              //     width: 50,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(100),
              //       gradient: MyGradient.main,
              //     ),
              //     child: const Icon(
              //       Icons.arrow_forward_ios_rounded,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

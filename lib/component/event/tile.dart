import 'dart:math';

import 'package:apollo/component/event/stock.dart';
import 'package:apollo/controller/home.dart';
import 'package:apollo/data/colors.dart';
import 'package:apollo/object/event.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventTile extends StatelessWidget {
  final int index;
  final EventData data;
  const EventTile({super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<HomeProv>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: InkWell(
        hoverColor: MyColors.primary,
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          prov.select(index);
        },
        onDoubleTap: () {},
        child: Card(
          elevation: prov.selected == index ? 6 : 0,
          color: MyColors.background,
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.headline,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: List.generate(
                            min(3, data.stocks.length),
                            (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: EventStock(
                                  code: data.stocks[index],
                                  impact: data.stockImpacts[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:apollo/component/event/insight.dart';
import 'package:apollo/component/event/view.dart';

import 'package:apollo/object/event.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final TabController tb;
  const HomeScreen({super.key, required this.tb});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EventData? selectedEvent;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 24),
        const Expanded(
          child: EventsView(),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: EventInsight(
              tb: widget.tb,
            ),
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}

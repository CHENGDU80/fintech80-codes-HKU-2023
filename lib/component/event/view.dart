import 'package:apollo/controller/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<HomeProv>();
    final events = prov.events;
    const subTitleStyle = TextStyle(fontSize: 48, fontWeight: FontWeight.w900);
    if (prov.events.isEmpty) {
      return const Center(
        child: SizedBox.square(
          dimension: 50,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return ListView(
      children: [
        const SizedBox(height: 60),
        const Text(
          "Top Events",
          style: subTitleStyle,
        ),
        for (var i = 0; i < 4; i++)
          if (events[i] == null) const SizedBox() else events[i]!,
        const _More(text: "More Top Events"),
        const Text(
          "Latest Events",
          style: subTitleStyle,
        ),
        for (var i = 4; i < 8; i++)
          if (events[i] == null) const SizedBox() else events[i]!,
        const _More(text: "More Latest Events"),
        const Text(
          'Hot Events',
          style: subTitleStyle,
        ),
        for (var i = 8; i < 12; i++)
          if (events[i] == null) const SizedBox() else events[i]!,
        const _More(text: "More Hot Events"),
      ],
    );
  }
}

class _More extends StatelessWidget {
  final String text;
  const _More({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.blue[200]),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.blue[200],
          ),
        ],
      ),
    );
  }
}

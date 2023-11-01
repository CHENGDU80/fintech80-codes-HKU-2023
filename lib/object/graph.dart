import 'package:flutter/material.dart';

class GraphData {
  late DateTime time;
  late double? price;
  GraphData(this.time, this.price);
}

class NumberData extends StatelessWidget {
  final String title;
  final String data;
  const NumberData({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
        Text(
          data,
          style: const TextStyle(fontSize: 25),
        ),
      ],
    );
  }
}

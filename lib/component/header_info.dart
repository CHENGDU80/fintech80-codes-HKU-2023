import 'package:apollo/component/network_round_image.dart';
import 'package:apollo/data/companies.dart';
import 'package:flutter/material.dart';

class HeadInfo extends StatelessWidget {
  final String name;
  final String price;
  const HeadInfo({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          const SizedBox(width: 40),
          NetworkRoundImage(name: name, size: 50),
          const SizedBox(width: 10),
          Text(
            Companies.fullName[name] ?? "NULL",
            style: const TextStyle(fontSize: 25),
          ),
          Expanded(child: Container()),
          Row(
            children: [
              Text(
                "$price USD",
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(width: 5),
              const Text(
                "+12%",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

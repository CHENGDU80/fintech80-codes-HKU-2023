import 'package:apollo/component/network_round_image.dart';
import 'package:apollo/controller/my_controller.dart';
import 'package:apollo/data/colors.dart';
import 'package:apollo/data/companies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockCard extends StatelessWidget {
  final String stockID;
  final TabController tb;
  const StockCard({super.key, required this.stockID, required this.tb});

  @override
  Widget build(BuildContext context) {
    var stockProvider = Provider.of<StockProvider>(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          stockProvider.setCurrentStock(stockID);
          tb.animateTo(1);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NetworkRoundImage(name: stockID, size: 40),
                  const SizedBox(width: 30),
                ],
              ),
              Text(Companies.fullName[stockID]!),
              Expanded(child: Container()),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "0.214\$",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "+12.12%",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

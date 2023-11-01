import 'package:apollo/component/network_round_image.dart';
import 'package:apollo/data/colors.dart';
import 'package:apollo/data/companies.dart';
import 'package:flutter/material.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({super.key});

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 20, bottom: 30),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.primary,
        ),
        child: ListView.builder(
            itemCount: Companies.data.length ~/ 2,
            itemBuilder: (BuildContext context, int index) {
              String name = Companies.data[index];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {},
                  child: ListTile(
                    visualDensity: VisualDensity.standard,
                    leading: NetworkRoundImage(name: name, size: 40),
                    title: Text(name),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

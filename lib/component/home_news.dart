import 'package:apollo/data/colors.dart';
import 'package:flutter/material.dart';

class HomeNewsView extends StatefulWidget {
  const HomeNewsView({super.key});

  @override
  State<HomeNewsView> createState() => _HomeNewsViewState();
}

class _HomeNewsViewState extends State<HomeNewsView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 20, bottom: 20),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.primary,
        ),
      ),
    );
  }
}

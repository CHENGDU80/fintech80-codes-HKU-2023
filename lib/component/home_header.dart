import 'package:apollo/controller/home.dart';
import 'package:apollo/controller/tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  final TabController tb;
  const HomeHeader({super.key, required this.tb});

  final menuButtonStyle = const TextStyle(fontSize: 18, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TabProv>();
    final joshi = context.watch<HomeProv>();
    return GestureDetector(
      onDoubleTap: () {
        joshi.sendNotification();
      },
      child: Card(
        elevation: 6,
        margin: EdgeInsets.zero,
        child: Container(
          width: 240,
          decoration: const BoxDecoration(color: Colors.black87),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "APOLLO",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Material(
                color: tb.index == 0 ? Colors.grey[600] : Colors.transparent,
                child: ListTile(
                  hoverColor: Colors.grey[600],
                  leading: const Icon(
                    CupertinoIcons.home,
                    color: Colors.white,
                  ),
                  onTap: () {
                    tb.animateTo(0);
                    prov.notify();
                  },
                  title: Text(
                    "Home",
                    style: menuButtonStyle,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Material(
                color: tb.index == 1 ? Colors.grey[600] : Colors.transparent,
                child: ListTile(
                    hoverColor: Colors.grey[600],
                    leading:
                        const Icon(Icons.multiline_chart, color: Colors.white),
                    onTap: () {
                      tb.animateTo(1);
                      prov.notify();
                    },
                    title: Text("Impact Analysis", style: menuButtonStyle)),
              ),
              const SizedBox(height: 20),
              Material(
                color: tb.index == 2 ? Colors.grey[600] : Colors.transparent,
                child: ListTile(
                  hoverColor: Colors.grey[600],
                  leading: const Icon(CupertinoIcons.news, color: Colors.white),
                  onTap: () {
                    // tb.animateTo(2);
                    // prov.notify();
                  },
                  title: Text("News", style: menuButtonStyle),
                ),
              ),
              const SizedBox(height: 20),
              Material(
                color: tb.index == 3 ? Colors.grey[600] : Colors.transparent,
                child: ListTile(
                  hoverColor: Colors.grey[600],
                  leading: const Icon(CupertinoIcons.graph_square,
                      color: Colors.white),
                  onTap: () {
                    tb.animateTo(3);
                    prov.notify();
                  },
                  title: Text("Stocks", style: menuButtonStyle),
                ),
              ),
              const Expanded(child: SizedBox()),
              const SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  hoverColor: Colors.grey[600],
                  leading:
                      const Icon(Icons.person_outline, color: Colors.white),
                  onTap: () {},
                  title: Text("Profile", style: menuButtonStyle),
                ),
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  hoverColor: Colors.grey[600],
                  leading:
                      const Icon(Icons.settings_outlined, color: Colors.white),
                  onTap: () {},
                  title: Text("Settings", style: menuButtonStyle),
                ),
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  hoverColor: Colors.grey[600],
                  leading: const Icon(Icons.help_outline_rounded,
                      color: Colors.white),
                  onTap: () {},
                  title: Text("Help Center", style: menuButtonStyle),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:apollo/component/chat.dart';
import 'package:apollo/component/home_header.dart';
import 'package:apollo/controller/home.dart';
import 'package:apollo/controller/my_controller.dart';
import 'package:apollo/controller/tab.dart';
import 'package:apollo/data/colors.dart';
import 'package:apollo/screens/graph.dart';
import 'package:apollo/screens/home.dart';
import 'package:apollo/screens/impact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<StockProvider>(create: (_) => StockProvider()),
    ChangeNotifierProvider<HomeProv>(create: (_) => HomeProv()),
    ChangeNotifierProvider(create: (_) => TabProv()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apollo',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: MyColors.background,
        floatingActionButton: const ChatButton(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
              tb: tabController,
            ),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    Tab(
                        child: HomeScreen(
                      tb: tabController,
                    )),
                    const Tab(child: ImpactScreen()),
                    const Tab(
                      child: SizedBox(),
                    ),
                    const Tab(child: GraphScreen()),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

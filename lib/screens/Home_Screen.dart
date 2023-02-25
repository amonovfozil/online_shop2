import 'package:flutter/material.dart';
import 'package:online_shop/Widgets/Side_bar.dart';
import 'package:online_shop/Widgets/savatcha_iconButton.dart';
import 'package:online_shop/screens/Magazin_pageScreen.dart';
import 'package:online_shop/screens/favority_pageScreen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magazin'),
        centerTitle: true,
        actions: [
          SavatchaIconButton(),
        ],
      ),
      drawer: SideBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.shade500,
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                indicatorWeight: 3,
                indicatorColor: Colors.amber,
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: 'Barchasi',
                  ),
                  Tab(
                    text: 'Sevimli',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MagazinPageScreen(),
                FavorityPageScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

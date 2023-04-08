import 'package:flutter/material.dart';
import 'package:shop_ecommerce/screens/home/components/leader_board.dart';
import 'package:shop_ecommerce/screens/home/components/explore.dart';

class HomeScreenPageView extends StatefulWidget {
  const HomeScreenPageView({super.key});

  @override
  State<HomeScreenPageView> createState() => _HomeScreenPageViewState();
}

class _HomeScreenPageViewState extends State<HomeScreenPageView> {
  @override
  Widget build(BuildContext context) {
    int? selectedMenu;
    PageController _pageController = PageController(initialPage: 0);
    void onTap(int index) {
      setState(() {
        selectedMenu = index;
      });
    }
    List<Widget> pages = [
    Explore(),
    LeaderBoard()
    ];
    return Scaffold(
      body: Column(
        children: [
         Expanded(
          flex: 1,
          child: 
          PageView(
                 onPageChanged: (index) {
                  onTap(index);
                },
                controller: _pageController,
                children: pages),
          ),
        ],
      ),
          
    );
  }
}

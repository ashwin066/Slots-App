import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/components/fade_indexed_stack.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/provider/go_to_page.dart';
import 'package:shop_ecommerce/screens/all_view/U_M_view.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/screens/my_slots/my_slots.dart';
import 'package:shop_ecommerce/screens/my_tickets/my_tickets.dart';
import 'package:shop_ecommerce/screens/profile/profile_screen.dart';
import 'package:shop_ecommerce/size_config.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, this.selectedMenu}) : super(key: key);

  static String routeName = "/main_page";
  int? selectedMenu;
  DateTime? currentBackPressTime;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
   
     
      WidgetsBinding.instance.addPostFrameCallback((_) => openThePage());
   
     if (widget.selectedMenu == null) {
      setState(() {
        widget.selectedMenu = 0;
      });
    }
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint("onMessage:");
        log("onMessage: $message");
        final snackBar =
            SnackBar(content: Text(message.notification?.title ?? ""));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
  openThePage() async {
    if (context.read<GoToPageProvider>().goToPath != null) {
      Navigator.of(context).push(PageTransition(
          type: PageTransitionType.theme,
          duration: Duration(milliseconds: 600),
          reverseDuration: Duration(milliseconds: 600),
          child: DetailsScreen(
            id: context.read<GoToPageProvider>().goToPath ?? "",
          )));
    }
    openThePage();
  }
  List<Widget> pages = [
    HomeScreen(),
    MyTickets(
      current: 0,
    ),
    MySlots(),
    ProfileScreen(),
  ];
  List<String> listOfNames = [
    "Home",
    "My Tickets",
    "My Slots",
    "Profile",
  ];
  List<String> listOfIcons = [
    "assets/icons/Home filled.svg",
    "assets/icons/ticket_dual_tone.svg",
    "assets/icons/slots_icon_filled.svg",
    "assets/icons/User Icon filled.svg",
  ];

  @override
  Widget build(BuildContext context) {
 
    Size size = MediaQuery.of(context).size;
    PageController _pageController =
        PageController(keepPage: true, initialPage: widget.selectedMenu ?? 0);
    void onTap(int index) {
      setState(() {
        widget.selectedMenu = index;
      });
    }

    return UnderMaintainanceView(
     
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            DateTime now = DateTime.now();
    
            if (widget.selectedMenu != 0) {
              onTap(0);
               _pageController.animateToPage(0,
                  duration: defaultDuration,
                  curve: Curves.fastLinearToSlowEaseIn);
              return false;
            } else if (widget.currentBackPressTime == null ||
                now.difference(widget.currentBackPressTime!) >
                    defaultDuration2sec) {
              widget.currentBackPressTime = now;
              Fluttertoast.showToast(
                  msg: "Press again to exit",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: DarkPurple,
                  textColor: aWhite,
                  fontSize: 16.0);
              return Future.value(false);
            }
            exit(0);
          },
          child: PageView(
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                onTap(index);
              },
              controller: _pageController,
              children: pages),
    
          // FadeIndexedStack(
          //   //this is optional
          //   //duration: Duration(seconds: 1),
          //   children: pages,
          //   index: widget.selectedMenu!,
          // ),
        ),
        bottomSheet: Container(
          margin: paddingMarginAll15,
          height: size.width * .220,
          decoration: BoxDecoration(
            color: aWhite,
            boxShadow: [
              BoxShadow(
                color: DarkPurple.withOpacity(.25),
                blurRadius: 25,
                offset: Offset(0, 0),
              ),
            ],
            borderRadius: borderRadius18,
          ),
          child: ListView.builder(
            itemCount: pages.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: size.width * .024),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (widget.selectedMenu != index) HapticFeedback.mediumImpact();
                onTap(index);
                _pageController.animateToPage(index,
                    duration: defaultDuration ,
                    curve: Curves.fastLinearToSlowEaseIn);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: defaultDuration,
                    margin: EdgeInsets.only(
                      //  bottom: index == widget.selectedMenu ? 0 : size.width * .029,
                      right: size.width * .0422,
                      left: size.width * .0422,
                    ),
                    width: size.width * .128,
                    height: size.width * .014,
                    decoration: BoxDecoration(
                      // gradient: linearGradient4,
                      color: index == widget.selectedMenu ? DarkPurple : null,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * .015),
                  AnimatedContainer(
                    duration: defaultDurationLate,
                    padding: EdgeInsets.all(5.5),
                    decoration: BoxDecoration(
                      //   gradient: linearGradient7,
                      color: index != widget.selectedMenu
                          ? null
                          : transparentDarkPurple.withOpacity(.06),
                      borderRadius: borderRadius50,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          listOfIcons[index],
                          height: size.width * .07,
                          width: size.width * .07,
                          color: index != widget.selectedMenu
                              ? DarkPurple.withOpacity(.65)
                              : DarkPurple,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    listOfNames[index],
                    style: index == widget.selectedMenu
                        ? text12DarkFw400
                        : text12DarkGrayFw400,
                  ),
                  SizedBox(height: size.width * .03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/fade_indexed_stack.dart';
import 'package:shop_ecommerce/components/footer.dart';
import 'package:shop_ecommerce/components/info_bottom_sheet.dart';
import 'package:shop_ecommerce/components/progress_segmented.dart';
import 'package:shop_ecommerce/provider/go_to_page.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/home/components/leader_board.dart';
import 'package:shop_ecommerce/components/main_banner_fetch.dart';
import 'package:shop_ecommerce/components/welcome_box.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/home/components/explore.dart';
import 'package:shop_ecommerce/screens/home/components/featured_cards.dart';
import 'package:shop_ecommerce/screens/home/components/home_screen_page_view.dart';
import 'package:shop_ecommerce/screens/home/components/popular_products.dart';
import 'package:shop_ecommerce/screens/home/components/section_title.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/screens/my_slots/my_slots.dart';
import 'package:shop_ecommerce/screens/my_tickets/my_tickets.dart';
import 'package:shop_ecommerce/screens/profile/profile_screen.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
    this.selectedMenu,
  }) : super(key: key);
  int? selectedMenu = 0;
  DateTime? currentBackPressTime;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body>  {
  final ServicePreferences _servicePreferences = ServicePreferences();




  @override
  Widget build(BuildContext context) {
    if (widget.selectedMenu == null) {
      setState(() {
        widget.selectedMenu = 0;
      });
    }
    List<Widget> pages = [
      Explore(),
      LeaderBoard(),
    ];
    List<String> listOfNames = [
      "Explore",
      "Winners List",
    ];
    List<String> listOfIcons = [
      "assets/images/explore.jpg",
      "assets/images/winner.jpg",
    ];

    void onTap(int index) {
      setState(() {
        widget.selectedMenu = index;
      });
    }

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenWidth(105)),
          WelcomeBox(),
          //Text(context.read<GoToPageProvider>().goToPath ?? "null"),
          SizedBox(height: getProportionateScreenWidth(15)),
          SizedBox(
            height: getProportionateScreenWidth(70),
            child: ListView.builder(
              itemCount: pages.length,
              scrollDirection: Axis.horizontal,
              padding: paddingMarginLR11,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  if (index != widget.selectedMenu) {
                    HapticFeedback.mediumImpact();
                    onTap(index);
                  }
                },
                child: SizedBox(
                  width: getProportionateScreenHeight(67),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.all(2.2),
                          decoration: BoxDecoration(
                              //   gradient: linearGradient7,
                              borderRadius: borderRadius150,
                              color: index == widget.selectedMenu
                                  ? Transparent
                                  : aBlack,
                              border: Border.all(
                                  width: getProportionateScreenHeight(2.3),
                                  color: index == widget.selectedMenu
                                      ? MediumPinkPurple
                                      : Transparent)),
                          child: ClipRRect(
                              borderRadius: borderRadius150,
                              child: Image.asset(
                                listOfIcons[index],
                                height: getProportionateScreenHeight(37),
                                width: getProportionateScreenHeight(37),
                              ))),
                      Text(
                        listOfNames[index],
                        style: index == widget.selectedMenu
                            ? text11DarkFw600
                            : text11DarkGrayFw400,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: size.width * .001),
                      AnimatedContainer(
                        alignment: Alignment.center,
                        duration: defaultDuration,
                        width: size.width * .15,
                        height: size.width * .009,
                        decoration: BoxDecoration(
                            // gradient: linearGradient4,
                            color: index == widget.selectedMenu
                                ? DarkPurple
                                : null,
                            borderRadius: borderRadius10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(height: getProportionateScreenWidth(10)),
          // ElevatedButton(
          //     onPressed: () {

          //     //  GetUserData().loadUserData(context);

          //       // _servicePreferences.readUserDataCache("firstName");
          //       // loadUserData();
          //       //    _service.showLocalNotification("mainTitle", "subTitle");
          //     },
          //     child: Text("Notify me")),
          FadeIndexedStack(
            duration: defaultDurationLate,
            //  physics: new NeverScrollableScrollPhysics(),
            index: widget.selectedMenu ?? 0,
            children: pages,
          ),

          //  FadeIndexedStack(index: widget.selectedMenu!, children: pages),
          const Footer(height: 120)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/enum.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/screens/map/map_screen.dart';
import 'package:shop_ecommerce/screens/profile/profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white, 
        // borderRadius:   BorderRadius.only(
        //   topLeft: Radius.circular(40.r),
        //   topRight: Radius.circular(40.r),
        // ),
        // border: Border(
        //   top: BorderSide(
        //     color: SecondaryColor.withOpacity(0.2),
        //     width: 1,
        //   ),
        // ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -5),
            blurRadius: 20,
            color: SecondaryColor.withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: SvgPicture.asset(
                  MenuState.home == selectedMenu
                      ? "assets/icons/Home filled.svg"
                      : "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? SecondaryColor
                      : inActiveIconColor,
                  height: 25.h,
                  width: 25.w,
                ),
                   onPressed: () => Navigator.of(context).push(PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                  child: HomeScreen())),
            ),
            IconButton(
              onPressed:   () => Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                    child: MapScreen())),
              icon: SvgPicture.asset(
                MenuState.favourite == selectedMenu
                    ? "assets/icons/Location point simple filled.svg"
                    : "assets/icons/Location point simple.svg",
                color: MenuState.favourite == selectedMenu
                    ? SecondaryColor
                    : inActiveIconColor,
                height: 25.h,
                width: 25.w,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                MenuState.message == selectedMenu
                    ? "assets/icons/Gift Icon filled.svg"
                    : "assets/icons/Gift Icon.svg",
                color: MenuState.message == selectedMenu
                    ? SecondaryColor
                    : inActiveIconColor,
                height: 25.h,
                width: 25.w,
              ),
            ),
            IconButton(
                icon: SvgPicture.asset(
                  MenuState.profile == selectedMenu
                      ? "assets/icons/User Icon filled.svg"
                      : "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? SecondaryColor
                      : inActiveIconColor,
                  height: 25.h,
                  width: 25.w,
                ),
                onPressed: () => Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                    child: ProfileScreen()))),
          ],
        ),
      ),
    );
  }
}

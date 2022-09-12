import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/components/back_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/cart/cart_screen.dart';
import 'package:shop_ecommerce/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarLeading extends StatelessWidget {
  const CustomAppBarLeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackButtton();
  }
}

class CustomMainAppBar extends StatelessWidget {
  const CustomMainAppBar(
      {Key? key, required this.title, required this.subtitle,required this.type})
      : super(key: key);
  final title;
  final subtitle;
  final type;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          color: PrimaryColor,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackButtton(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: aWhite,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              type=="cart"?          
              Container(
                padding: EdgeInsets.all(5),
                 decoration: BoxDecoration(
                  color: SecondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                child: Text("Offers",style:  TextStyle(
                        color: aWhite,
                        fontSize: 13.sp,
                        fontWeight:FontWeight.w500
                      ),),
              )
              :
                IconBtnWithCounter(
                      svgSrc: "assets/icons/Cart Icon.svg",
                      press: () =>
                          Navigator.pushNamed(context, CartScreen.routeName),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
